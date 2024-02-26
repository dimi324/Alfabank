CREATE VIEW view_cube_test AS
SELECT 
dim_ZeitID,
dim_OrtID,
dim_RatingID,
dim_KundenID,
dim_PortfolioID,
Fact_Beschreibung,
Fact_Wert
FROM dwh_alfabank.dwh_facttable_test2
INNER JOIN dwh_alfabank.dwh_fact_kpis on dwh_alfabank.dwh_fact_kpis.FactID = dwh_alfabank.dwh_facttable_test2.FactID;