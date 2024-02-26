USE db_AlfaBank;

CREATE VIEW view_TransactionDetails AS
SELECT
	Zeitstempel,
    Preis,
    Anzahl,
    Typ as 'Transaktionstyp',
    Produkt_Beschreibung,
    tbl_boersen.name as 'Börse',
    tbl_staedte.name as 'Stadt',
    tbl_laender.name as 'Land',
    tbl_kontinenten.name as 'Kontinent',
    tbl_portfolios.beschreibung as 'Portfolio',
    Kunden_Beschreibung,
    Gender,
    Altersklasse,
    tbl_kundentypen.Beschreibung as 'Kunde'
FROM tbl_transaktionen
INNER JOIN tbl_transaktionstypen ON tbl_transaktionstypen.transaktionstypID = tbl_transaktionen.transaktionstypID
INNER JOIN tbl_produkte ON tbl_produkte.produktID = tbl_transaktionen.produktID
INNER JOIN tbl_produkttypen ON tbl_produkttypen.ProdukttypID = tbl_produkte.ProdukttypID
INNER JOIN tbl_boersen ON tbl_boersen.BoersenID = tbl_produkte.BoersenID
INNER JOIN tbl_staedte ON tbl_staedte.StadtID = tbl_boersen.StadtID
INNER JOIN tbl_laender ON tbl_laender.LandID = tbl_staedte.LandID
INNER JOIN tbl_kontinenten ON tbl_kontinenten.KontinentID = tbl_laender.KontinentID
INNER JOIN tbl_portfolios on tbl_portfolios.PortfolioID = tbl_transaktionen.PortfolioID
INNER JOIN tbl_Kundenportfolio on tbl_portfolios.PortfolioID = tbl_Kundenportfolio.PortfolioID
INNER JOIN tbl_Kunden on tbl_Kundenportfolio.KundenID = tbl_Kunden.KundenID
INNER JOIN tbl_Gender on tbl_Gender.GenderID = tbl_Kunden.GenderID
INNER JOIN tbl_Altersklassen on tbl_Altersklassen.AltersklasseID = tbl_Kunden.AltersklasseID
INNER JOIN tbl_Kundentypen on tbl_Kundentypen.KundentypID = tbl_Kunden.KundentypID
