import yfinance as yf
import pandas as pd
import numpy as np
import mysql.connector
from datetime import datetime, timedelta
from sqlalchemy import create_engine

# Connect to Db
db_config = {
    "host": "127.0.0.1",
    "user": "root",
    "password": "",
    "database": "dwh_alfabank"
}

db_connection = mysql.connector.connect(**db_config)
cursor = db_connection.cursor()

# SQL query to select data from the database
sql_query_cube = """
    SELECT dim_ZeitID, dim_OrtID, dim_RatingID, dim_KundenID, dim_PortfolioID, dwh_facttable.FactID, Fact_Wert, dwh_fact_kpis.Fact_Beschreibung FROM dwh_alfabank.dwh_facttable
INNER JOIN dwh_fact_kpis ON dwh_fact_kpis.FactID = dwh_facttable.FactID ORDER BY RAND() LIMIT 1000;
"""

# Reading data from the database into a pandas DataFrame
data_frame_cube = pd.read_sql(sql_query_cube, con=db_connection)
data_frame_cube[['Portfolio', 'Produkt']] = data_frame_cube['dim_PortfolioID'].str.split('-', expand=True)
print(data_frame_cube)


# log for CDC
data_frame_log = pd.DataFrame(columns=['dim_ZeitID', 'Datum_Aktualisierung', 'Kommentar'])

# Loop through each row in the DataFrame
for index, row in data_frame_cube.iterrows():
    # Get values from the current row
    Zeitvar = datetime.strptime(row['dim_ZeitID'], '%Y%m%d')
    end_date = Zeitvar.strftime('%Y-%m-%d')
    # start_date = Zeitvar - timedelta(days=356*10)
    start_date = Zeitvar - timedelta(days=30)
    start_date = start_date.strftime('%Y-%m-%d')
    # different procedure for different Facts
    fact_beschreibung = row['Fact_Beschreibung']
    if fact_beschreibung == 'ValueAtRisk95':
        try:
            stock_data = {}
            stock_data = yf.download(row['Produkt'], start=start_date, end=end_date)
            stock_data['Daily_Return'] = stock_data['Adj Close'].pct_change()
            confidence_level = float(0.95)
            holding_period = 1  # Number of days for the holding period
            returns = stock_data['Daily_Return'].dropna()
            sorted_returns = returns.sort_values()
            var_index = int(len(sorted_returns) * (1 - confidence_level))
            var_value = sorted_returns[var_index]
            var = float(var_value * holding_period)
            data_frame_cube.at[index, 'Fact_Wert'] = var
        except:
            pass
        #print(stock_data)
    elif fact_beschreibung == 'Nominelle Wert':
        try:
            stock_data = {}
            stock_data = yf.download(row['Produkt'], start=start_date, end=end_date)
            data_frame_cube.at[index, 'Fact_Wert'] = stock_data['Close'].iloc[-1]
        except:
            pass
    elif fact_beschreibung == 'Anzahl von Produkten':
        # DUMMMY
        data_frame_cube.at[index, 'Fact_Wert'] = 3
    elif fact_beschreibung == 'Gesammtes Trading Volumen':
        # DUMMMY
        data_frame_cube.at[index, 'Fact_Wert'] = 4
    # Add log entry to data_frame_log
    log_time = datetime.now()
    log_message = f"Processed FactID: {row['FactID']}, Produkt: {row['Produkt']}, Fact_Beschreibung: {row['Fact_Beschreibung']}"
    log_entry = {'dim_ZeitID': row['dim_ZeitID'], 'Datum_Aktualisierung': log_time, 'Kommentar': log_message}
    data_frame_log = pd.concat([data_frame_log, pd.DataFrame(log_entry, index=[0])], ignore_index=True)
    
#print(data_frame_cube.describe())
# remove helping columns
data_frame_cube = data_frame_cube.drop(columns=['Fact_Beschreibung'])
data_frame_cube = data_frame_cube.drop(columns=['Portfolio'])
data_frame_cube = data_frame_cube.drop(columns=['Produkt'])


#print(data_frame_cube)
#prepare export
engine = create_engine('mysql+mysqlconnector://' + db_config['user'] + ':' + db_config['password'] + '@' + db_config['host'] + '/' + db_config['database'], echo=False)

# Export the modified DataFrame to dwh_facttable
data_frame_cube.to_sql(name='dwh_facttable_test2', con=engine, if_exists='append', index=False)
data_frame_log.to_sql(name='dwh_log_cdc_facttable', con=engine, if_exists='append', index=False)

# Close database connection
cursor.close()
db_connection.close()
