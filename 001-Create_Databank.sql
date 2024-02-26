CREATE DATABASE IF NOT EXISTS db_AlfaBank;
USE db_AlfaBank;

DROP TABLE IF EXISTS tbl_KundenPortfolio;
DROP TABLE IF EXISTS tbl_Kunden;
DROP TABLE IF EXISTS tbl_Transaktionen;
DROP TABLE IF EXISTS tbl_Portfolios;
DROP TABLE IF EXISTS tbl_TransaktionsTypen;
DROP TABLE IF EXISTS tbl_Produkte;
DROP TABLE IF EXISTS tbl_Rating;
DROP TABLE IF EXISTS tbl_RatingKategorien;
DROP TABLE IF EXISTS tbl_ProduktTypen;
DROP TABLE IF EXISTS tbl_Boersen;
DROP TABLE IF EXISTS tbl_Staedte;
DROP TABLE IF EXISTS tbl_Laender;
DROP TABLE IF EXISTS tbl_Kontinenten;
DROP TABLE IF EXISTS tbl_Gender;
DROP TABLE IF EXISTS tbl_Altersklassen;
DROP TABLE IF EXISTS tbl_Kundentypen;

CREATE TABLE tbl_Gender(
	GenderID char(1) NOT NULL PRIMARY KEY,
    Gender varchar(30) NOT NULL);

CREATE TABLE tbl_Altersklassen(
	AltersklasseID int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Altersklasse varchar(10) NOT NULL,
    Beschreibung varchar(30) NOT NULL);

CREATE TABLE tbl_Kundentypen(
	KundentypID varchar(10) NOT NULL PRIMARY KEY,
    Beschreibung varchar(30) NOT NULL);
    
CREATE TABLE tbl_Kunden(
	KundenID int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    KundentypID varchar(10) NOT NULL,
    AltersklasseID int NOT NULL,
    GenderID char(1) NOT NULL,
    Kunden_Beschreibung varchar(30),
    CONSTRAINT FK_Kunden_Kundentypen FOREIGN KEY (KundentypID) REFERENCES tbl_KundenTypen (KundentypID),
    CONSTRAINT FK_Kunden_Altersklassen FOREIGN KEY (AltersklasseID) REFERENCES tbl_Altersklassen (AltersklasseID),
    CONSTRAINT FK_Kunden_Gender FOREIGN KEY (GenderID) REFERENCES tbl_Gender (GenderID));

CREATE TABLE tbl_Portfolios(
	PortfolioID int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Beschreibung varchar(30) NOT NULL);
    
CREATE TABLE tbl_KundenPortfolio(
	PortfolioID int NOT NULL,
    KundenID int NOT NULL,
    CONSTRAINT FK_KundenPortfolios_Portfolios FOREIGN KEY (PortfolioID) REFERENCES tbl_Portfolios (PortfolioID),
    CONSTRAINT FK_KundenPortfolios_Kunden FOREIGN KEY (KundenID) REFERENCES tbl_Kunden (KundenID),
    PRIMARY KEY (PortfolioID, KundenID));

CREATE TABLE tbl_Kontinenten(
	KontinentID int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Name varchar(30) NOT NULL);
    
CREATE TABLE tbl_Laender(
	LandID int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Name varchar(30) NOT NULL,
    KontinentID int NOT NULL,
    CONSTRAINT FK_Laender_Kontinente FOREIGN KEY (KontinentID) REFERENCES tbl_Kontinenten (KontinentID));
    
CREATE TABLE tbl_Staedte(
	StadtID int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Name varchar(30) NOT NULL,
    LandID int NOT NULL,
    CONSTRAINT FK_Staedte_Laender FOREIGN KEY (LandID) REFERENCES tbl_Laender (LandID));
    
CREATE TABLE tbl_Boersen(
	BoersenID varchar(10) NOT NULL PRIMARY KEY,
    Name varchar(50) NOT NULL,
    StadtID int NOT NULL,
    CONSTRAINT FK_Boersen_Staedte FOREIGN KEY (StadtID) REFERENCES tbl_Staedte (StadtID));

CREATE TABLE tbl_ProduktTypen(
	ProduktTypID int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Beschreibung varchar(30) NOT NULL);
    
CREATE TABLE tbl_RatingKategorien(
	Rating_Kategorie char(1) NOT NULL PRIMARY KEY,
    Beschreibung varchar(30) NOT NULL);
    
CREATE TABLE tbl_Rating(
	Rating varchar(2) NOT NULL PRIMARY KEY,
    Rating_Kategorie char(1) NOT NULL,
    CONSTRAINT FK_Rating_RatingKategorien FOREIGN KEY (Rating_Kategorie) REFERENCES tbl_RatingKategorien (Rating_Kategorie));
    
CREATE TABLE tbl_Produkte(
	ProduktID varchar(20) NOT NULL PRIMARY KEY,
    Produkt_Beschreibung varchar(30) NOT NULL,
    ProduktTypID int NOT NULL,
    BoersenID varchar(10) NOT NULL,
    Rating varchar(2) NOT NULL,
    CONSTRAINT FK_Produkte_Boersen FOREIGN KEY (BoersenID) REFERENCES tbl_Boersen (BoersenID),
    CONSTRAINT FK_Produkte_Produkttypen FOREIGN KEY (ProdukttypID) REFERENCES tbl_Produkttypen (ProdukttypID),
    CONSTRAINT FK_Produkte_Rating FOREIGN KEY (Rating) REFERENCES tbl_Rating (Rating));
    
CREATE TABLE tbl_TransaktionsTypen(
	TransaktionsTypID int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Typ varchar(10) NOT NULL);
    
CREATE TABLE tbl_Transaktionen(
	TransaktionsID int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    PortfolioID int NOT NULL,
    ProduktID varchar(20) NOT NULL,
    Zeitstempel datetime NOT NULL DEFAULT NOW(),
    Preis decimal(10,2) NOT NULL,
    Anzahl smallint DEFAULT 1 NOT NULL,
    TransaktionsTypID int NOT NULL,
    CONSTRAINT FK_Transaktionen_Portfolios FOREIGN KEY (PortfolioID) REFERENCES tbl_Portfolios (PortfolioID),
    CONSTRAINT FK_Transaktionen_Produkte FOREIGN KEY (ProduktID) REFERENCES tbl_Produkte (ProduktID),
    CONSTRAINT FK_Transaktionen_TransaktionsTypen FOREIGN KEY (TransaktionsTypID) REFERENCES tbl_TransaktionsTypen (TransaktionsTypID));


