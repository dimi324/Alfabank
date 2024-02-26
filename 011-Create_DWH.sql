CREATE DATABASE IF NOT EXISTS dwh_AlfaBank;
USE dwh_AlfaBank;

DROP TABLE IF EXISTS dwh_FactTable;
DROP TABLE IF EXISTS dwh_FactTable_test2;
DROP TABLE IF EXISTS dwh_Fact_KPIs;
DROP TABLE IF EXISTS dwh_dim_Orte;
DROP TABLE IF EXISTS dwh_dim_Rating;
DROP TABLE IF EXISTS dwh_dim_Kunden;
DROP TABLE IF EXISTS dwh_dim_Portfolios;
DROP TABLE IF EXISTS dwh_dim_Portfolios_Produkte;
DROP TABLE IF EXISTS dwh_dim_Zeitraum;

CREATE TABLE dwh_dim_Zeitraum(
ID char(8) PRIMARY KEY NOT NULL -- YYYYMMDD  202101
,Beschreibung varchar(20) NOT NULL -- …  Jänner 2021
,Datum date NOT NULL -- 2021-01-31
,MonatBezeichnung varchar(20) NOT NULL -- Jänner 2021
,MonatName varchar(15) NOT NULL -- Jänner
,MonatNameKurz char(3) NOT NULL -- Jän
,MonatNrTxt char(2) NOT NULL -- 01
,MonatNrNum tinyint NOT NULL -- 1
,MonatJahr char(7) NOT NULL -- 2021.01
,MonatID_Vorjahr char(7) NOT NULL
,QuartalID smallint NOT NULL -- 20211
,QuartalBezeichnung char(7) NOT NULL -- Q1 2021
,QuartalNr tinyint NOT NULL -- 1
,QuartalName char(9) NOT NULL  -- 1.Quartal
,QuartalNameKurz char(2) NOT NULL -- Q1
,QuartalJahr char(7) NOT NULL -- 2021.Q1
,QuartalID_Vorjahr char(7) NOT NULL --  2020.Q1
,Jahr smallint NOT NULL -- 2021
,Vorjahr smallint NOT NULL --  2020
);

CREATE TABLE dwh_dim_Orte(
	dim_OrtID varchar(10) NOT NULL PRIMARY KEY,
	Boerse varchar (50) NOT NULL,
    Stadt varchar(30) NOT NULL,
    Land varchar(30) NOT NULL,
    Kontinent varchar(30) NOT NULL
    );

CREATE TABLE dwh_dim_Rating(
	dim_RatingID smallint NOT NULL PRIMARY KEY AUTO_INCREMENT,
	Rating varchar(3) NOT NULL,
    Rating_Beschreibung varchar(30) NOT NULL,
    Kategorie varchar(30) NOT NULL
    );
    
CREATE TABLE dwh_dim_Kunden(
	dim_KundenID int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Kundentyp  varchar(30) NOT NULL,
    Altersklasse  varchar(10) NOT NULL,
    Gender varchar(30) NOT NULL,
    Kunden_Beschreibung varchar(30) NOT NULL
    );
    
CREATE TABLE dwh_dim_Portfolios_Produkte(
    ProduktID varchar(20) NOT NULL PRIMARY KEY,
    Produkt_Beschreibung varchar(30) NOT NULL,
    Produkt_Typ varchar(30) NOT NULL
    );
    
CREATE TABLE dwh_dim_Portfolios(
	dim_PortfolioID varchar(32) NOT NULL PRIMARY KEY,
    PortfolioID  int NOT NULL,
    ProduktID varchar(20) NOT NULL,
    Beschreibung varchar(30),
    CONSTRAINT FK_dwh_dim_Portfolios_Portfolios_Produkte FOREIGN KEY (ProduktID) REFERENCES dwh_dim_Portfolios_Produkte (ProduktID)
    );

CREATE TABLE dwh_Fact_KPIs(
	FactID smallint NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Fact_Beschreibung varchar(30) NOT NULL
    );
    
CREATE TABLE dwh_FactTable(
	dim_ZeitID char(8) NOT NULL,
    dim_OrtID varchar(10) NOT NULL,
    dim_RatingID smallint NOT NULL,
    dim_KundenID int NOT NULL,
    dim_PortfolioID varchar(32) NOT NULL,
    FactID smallint NOT NULL,
    Fact_Wert float NOT NULL DEFAULT -1,
    PRIMARY KEY (dim_ZeitID, dim_OrtID, dim_RatingID, dim_KundenID, dim_PortfolioID, FactID),
    CONSTRAINT FK_dwh_FactTable_dim_Zeitraum FOREIGN KEY (dim_ZeitID) REFERENCES dwh_dim_Zeitraum (ID),
    CONSTRAINT FK_dwh_FactTable_dim_Orte FOREIGN KEY (dim_OrtID) REFERENCES dwh_dim_Orte (dim_OrtID),
    CONSTRAINT FK_dwh_FactTable_dim_Rating FOREIGN KEY (dim_RatingID) REFERENCES dwh_dim_Rating (dim_RatingID),
    CONSTRAINT FK_dwh_FactTable_dim_Kunden FOREIGN KEY (dim_KundenID) REFERENCES dwh_dim_Kunden (dim_KundenID),
    CONSTRAINT FK_dwh_FactTable_dim_Portfolios FOREIGN KEY (dim_PortfolioID) REFERENCES dwh_dim_Portfolios (dim_PortfolioID),
    CONSTRAINT FK_dwh_FactTable_dim_Fact_KPIs FOREIGN KEY (FactID) REFERENCES dwh_Fact_KPIs (FactID)
    );
    
    CREATE TABLE dwh_FactTable_test2(
	dim_ZeitID char(8) NOT NULL,
    dim_OrtID varchar(10) NOT NULL,
    dim_RatingID smallint NOT NULL,
    dim_KundenID int NOT NULL,
    dim_PortfolioID varchar(32) NOT NULL,
    FactID smallint NOT NULL,
    Fact_Wert float NOT NULL DEFAULT -1,
    PRIMARY KEY (dim_ZeitID, dim_OrtID, dim_RatingID, dim_KundenID, dim_PortfolioID, FactID));