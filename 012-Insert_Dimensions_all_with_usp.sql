USE dwh_AlfaBank;
SET FOREIGN_KEY_CHECKS = 0;
INSERT INTO dwh_AlfaBank.dwh_dim_rating (Rating, Kategorie, Rating_Beschreibung)
	SELECT 
		db_AlfaBank.tbl_rating.Rating, 
        db_AlfaBank.tbl_rating.Rating_Kategorie as 'Kategorie', 
        db_AlfaBank.tbl_ratingkategorien.Beschreibung as 'Rating_Beschreibung'
	FROM db_AlfaBank.tbl_rating
	INNER JOIN db_AlfaBank.tbl_ratingkategorien on db_AlfaBank.tbl_rating.Rating_Kategorie = db_AlfaBank.tbl_ratingkategorien.Rating_Kategorie
    Order by rating;
    
INSERT INTO dwh_AlfaBank.dwh_dim_portfolios_produkte
	SELECT 
		db_AlfaBank.tbl_produkte.ProduktID, 
		db_AlfaBank.tbl_produkte.Produkt_Beschreibung, 
		db_AlfaBank.tbl_produkttypen.Beschreibung as 'Produkt_Typ'
	FROM db_AlfaBank.tbl_produkte
    INNER JOIN db_AlfaBank.tbl_produkttypen  on db_AlfaBank.tbl_produkte.ProduktTypID = db_AlfaBank.tbl_produkttypen.ProduktTypID;

INSERT INTO dwh_AlfaBank.dwh_dim_portfolios
	SELECT DISTINCT
		CONCAT(db_AlfaBank.tbl_portfolios.PortfolioID, '-', db_AlfaBank.tbl_Transaktionen.ProduktID) AS dim_PortfolioID,
		db_AlfaBank.tbl_portfolios.PortfolioID,
		db_AlfaBank.tbl_Transaktionen.ProduktID,
		db_AlfaBank.tbl_portfolios.Beschreibung
	FROM db_AlfaBank.tbl_portfolios
	INNER JOIN db_AlfaBank.tbl_transaktionen on db_AlfaBank.tbl_transaktionen.PortfolioID = db_AlfaBank.tbl_portfolios.PortfolioID;
    
INSERT INTO dwh_AlfaBank.dwh_dim_orte
	
	SELECT 
		db_AlfaBank.tbl_boersen.BoersenID as 'dim_OrtID', 
        db_AlfaBank.tbl_boersen.Name as 'Boerse', 
        db_AlfaBank.tbl_staedte.Name as 'Stadt', 
        db_AlfaBank.tbl_laender.Name as 'Land', 
        db_AlfaBank.tbl_kontinenten.Name as 'Kontinent'
	FROM db_AlfaBank.tbl_boersen
    INNER JOIN db_AlfaBank.tbl_staedte ON db_AlfaBank.tbl_staedte.StadtID = db_AlfaBank.tbl_boersen.StadtID
    INNER JOIN db_AlfaBank.tbl_laender on db_AlfaBank.tbl_laender.LandID = db_AlfaBank.tbl_staedte.LandID
    INNER JOIN db_AlfaBank.tbl_kontinenten on db_AlfaBank.tbl_kontinenten.KontinentID = db_AlfaBank.tbl_laender.KontinentID
    ;

INSERT INTO dwh_AlfaBank.dwh_dim_kunden
	SELECT 
		db_AlfaBank.tbl_kunden.KundenID as 'dim_KundenID', 
		db_AlfaBank.tbl_kundentypen.Beschreibung as 'Kundentyp',
		db_AlfaBank.tbl_altersklassen.Altersklasse as 'Altersklasse',
		db_AlfaBank.tbl_gender.Gender,
		db_AlfaBank.tbl_kunden.Kunden_Beschreibung
	FROM db_AlfaBank.tbl_kunden
	INNER JOIN db_AlfaBank.tbl_kundentypen ON db_AlfaBank.tbl_kundentypen.KundentypID = db_AlfaBank.tbl_kunden.KundentypID
	INNER JOIN db_AlfaBank.tbl_altersklassen ON db_AlfaBank.tbl_altersklassen.AltersklasseID = db_AlfaBank.tbl_kunden.AltersklasseID
	INNER JOIN db_AlfaBank.tbl_gender ON db_AlfaBank.tbl_gender.GenderID = db_AlfaBank.tbl_kunden.GenderID
	;

INSERT INTO dwh_AlfaBank.dwh_Fact_KPIs (Fact_Beschreibung)
VALUES
	('Nominelle Wert'), ('ValueAtRisk95'), ('Anzahl von Produkten'), ('Gesammtes Trading Volumen');

-- DROP PROCEDURE IF EXISTS usp_dwh_dim_zeitraum_fill;
DELIMITER //

CREATE PROCEDURE usp_dwh_dim_zeitraum_fill()
BEGIN
	DECLARE datumvar date;
	DECLARE VID char(8); -- YYYYMMDD  202101
	DECLARE VBeschreibung varchar(20); -- …  Jänner 2021
	DECLARE VDatum date; -- 2021-01-31
	DECLARE VMonatBezeichnung varchar(20); -- Jänner 2021
	DECLARE VMonatName varchar(15); -- Jänner
	DECLARE VMonatNameKurz char(3); -- Jän
	DECLARE VMonatNrTxt char(2); -- 01
	DECLARE VMonatNrNum tinyint; -- 1
	DECLARE VMonatJahr char(7); -- 2021.01
	DECLARE VMonatID_Vorjahr char(7);
	DECLARE VQuartalID smallint; -- 20211
	DECLARE VQuartalBezeichnung char(7); -- Q1 2021
	DECLARE VQuartalNr tinyint; -- 1
	DECLARE VQuartalName char(9);  -- 1.Quartal
	DECLARE VQuartalNameKurz char(2); -- Q1
	DECLARE VQuartalJahr char(7); -- 2021.Q1
	DECLARE VQuartalID_Vorjahr char(7); --  2020.Q1
	DECLARE VJahr smallint; -- 2021
	DECLARE VVorjahr smallint; --  2020;
            
	SET datumvar = (SELECT(DATE_SUB(DATE_SUB(CURRENT_DATE(),  INTERVAL DAYOFYEAR(CURRENT_DATE()) Day),  INTERVAL 0 Year)));
    SET lc_time_names = 'de_DE';
    
    WHILE datumvar < (SELECT(DATE_ADD(LAST_DAY(DATE_ADD(NOW(), INTERVAL 12-MONTH(NOW()) MONTH)),  INTERVAL 0 Year))) DO
		SET datumvar = (SELECT (DATE_ADD(datumvar, INTERVAL 1 DAY)));
		SET VID = datumvar+0;
		SET VBeschreibung = (SELECT DATE_FORMAT(datumvar, '%M %Y'));
		SET VDatum = datumvar;
		SET VMonatBezeichnung = (SELECT DATE_FORMAT(datumvar, '%M %Y'));
		SET VMonatName = (SELECT DATE_FORMAT(datumvar, '%M'));
		SET VMonatNameKurz = (SELECT DATE_FORMAT(datumvar, '%b'));
		SET VMonatNrTxt = (SELECT DATE_FORMAT(datumvar, '%m'));
		SET VMonatNrNum = (SELECT DATE_FORMAT(datumvar, '%c'));
		SET VMonatJahr = (SELECT DATE_FORMAT(datumvar, '%Y.%m'));
		SET VMonatID_Vorjahr = (SELECT DATE_FORMAT(DATE_SUB(datumvar, INTERVAL 1 YEAR), '%Y.%m'));
		SET VQuartalID = (SELECT CAST(CONCAT(YEAR(datumvar), QUARTER(datumvar)) AS UNSIGNED));
		SET VQuartalBezeichnung = (SELECT CONCAT('Q',QUARTER(datumvar),' ',(SELECT DATE_FORMAT(DATE_SUB(datumvar, INTERVAL 1 YEAR), '%Y'))));
		SET VQuartalNr = (SELECT QUARTER(datumvar));
		SET VQuartalName = (SELECT CONCAT(VQuartalNr, '.Quartal'));
		SET VQuartalNameKurz = (SELECT CONCAT('Q', VQuartalNr));
		SET VQuartalJahr = (SELECT CONCAT(YEAR(datumvar),'.', VQuartalNameKurz));
		SET VQuartalID_Vorjahr = (SELECT CONCAT(YEAR(DATE_SUB(datumvar, INTERVAL 1 YEAR)),'.', VQuartalNameKurz));
		SET VJahr = (SELECT YEAR(datumvar));
		SET VVorjahr = (SELECT (YEAR(DATE_SUB(datumvar, INTERVAL 1 YEAR))));
		
		INSERT INTO dwh_AlfaBank.dwh_dim_zeitraum
			(ID
			, Datum
            , Beschreibung
			, MonatBezeichnung 
			, MonatName
			, MonatNameKurz 
			, MonatNrTxt 
			, MonatNrNum 
			, MonatJahr 
			, MonatID_Vorjahr 
			, QuartalID
			, QuartalBezeichnung 
			, QuartalNr 
			, QuartalName 
			, QuartalNameKurz 
			, QuartalJahr 
			, QuartalID_Vorjahr 
			, Jahr 
			, Vorjahr)
        VALUES (VID
			, VDatum
            , VBeschreibung
			, VMonatBezeichnung 
			, VMonatName
			, VMonatNameKurz 
			, VMonatNrTxt 
			, VMonatNrNum 
			, VMonatJahr 
			, VMonatID_Vorjahr 
			, VQuartalID
			, VQuartalBezeichnung 
			, VQuartalNr 
			, VQuartalName 
			, VQuartalNameKurz 
			, VQuartalJahr 
			, VQuartalID_Vorjahr 
			, VJahr 
			, VVorjahr)
		;
        END WHILE;
END;
//
DELIMITER ;

CALL usp_dwh_dim_zeitraum_fill;
SET FOREIGN_KEY_CHECKS = 1;
