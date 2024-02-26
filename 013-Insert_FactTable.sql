USE dwh_AlfaBank;
INSERT INTO dwh_AlfaBank.dwh_facttable (dim_ZeitID, dim_OrtID, dim_RatingID, dim_KundenID, dim_PortfolioID, FactID)
SELECT 
	dwh_AlfaBank.dwh_dim_zeitraum.ID,
    dwh_AlfaBank.dwh_dim_orte.dim_OrtID,
    dwh_AlfaBank.dwh_dim_rating.dim_RatingID,
    dwh_AlfaBank.dwh_dim_kunden.dim_KundenID,
    dwh_AlfaBank.dwh_dim_portfolios.dim_PortfolioID,
    dwh_AlfaBank.dwh_fact_KPIs.FactID
FROM dwh_AlfaBank.dwh_dim_zeitraum, dwh_AlfaBank.dwh_dim_orte, dwh_AlfaBank.dwh_dim_rating, dwh_AlfaBank.dwh_dim_kunden, dwh_AlfaBank.dwh_dim_portfolios, dwh_AlfaBank.dwh_fact_KPIs
WHERE NOT EXISTS (SELECT dim_ZeitID, dim_OrtID, dim_RatingID, dim_KundenID, dim_PortfolioID, FactID FROM dwh_AlfaBank.dwh_FactTable 
WHERE dwh_AlfaBank.dwh_dim_zeitraum.ID = dim_ZeitID AND dwh_AlfaBank.dwh_dim_orte.dim_OrtID = dim_OrtID AND dwh_AlfaBank.dwh_dim_rating.dim_RatingID = dim_RatingID 
AND dwh_AlfaBank.dwh_dim_Kunden.dim_KundenID = dim_KundenID AND dwh_AlfaBank.dwh_dim_Portfolios.dim_PortfolioID = dim_PortfolioID AND dwh_AlfaBank.dwh_fact_KPIs.FactID = FactID)
