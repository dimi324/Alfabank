USE db_AlfaBank;

CREATE VIEW view_Portfolio_zusammensetzung AS
SELECT
    tbl_portfolios.PortfolioID,
    tbl_transaktionen.ProduktID,
    SUM(CASE WHEN tbl_transaktionstypen.Typ = 'Buy' THEN tbl_transaktionen.Anzahl ELSE 0 END) AS SumBuy,
    SUM(CASE WHEN tbl_transaktionstypen.Typ = 'Sell' THEN tbl_transaktionen.Anzahl ELSE 0 END) AS SumSell,
    SUM(CASE WHEN tbl_transaktionstypen.Typ = 'Buy' THEN tbl_transaktionen.Anzahl ELSE -tbl_transaktionen.Anzahl END) AS GesamtSum
FROM tbl_portfolios
INNER JOIN tbl_transaktionen ON tbl_transaktionen.PortfolioID = tbl_portfolios.PortfolioID
INNER JOIN tbl_transaktionstypen ON tbl_transaktionstypen.TransaktionsTypID = tbl_transaktionen.TransaktionsTypID
GROUP BY tbl_portfolios.PortfolioID, tbl_transaktionen.ProduktID;


    