USE db_AlfaBank;

-- Remove foreign key constraints
ALTER TABLE tbl_KundenPortfolio DROP FOREIGN KEY FK_KundenPortfolios_Portfolios, DROP FOREIGN KEY FK_KundenPortfolios_Kunden;
ALTER TABLE tbl_Transaktionen DROP FOREIGN KEY FK_Transaktionen_Portfolios, DROP FOREIGN KEY FK_Transaktionen_Produkte, 
								DROP FOREIGN KEY FK_Transaktionen_TransaktionsTypen, AUTO_INCREMENT=1;
ALTER TABLE tbl_Produkte DROP FOREIGN KEY FK_Produkte_Boersen, DROP FOREIGN KEY FK_Produkte_Produkttypen, DROP FOREIGN KEY FK_Produkte_Rating,AUTO_INCREMENT=1;
ALTER TABLE tbl_Rating DROP FOREIGN KEY FK_Rating_RatingKategorien;
ALTER TABLE tbl_Staedte DROP FOREIGN KEY FK_Staedte_Laender, AUTO_INCREMENT=1;
ALTER TABLE tbl_Boersen DROP FOREIGN KEY FK_Boersen_Staedte;
ALTER TABLE tbl_Laender DROP FOREIGN KEY FK_Laender_Kontinente, AUTO_INCREMENT=1;
ALTER TABLE tbl_Kunden DROP FOREIGN KEY FK_Kunden_Kundentypen, DROP FOREIGN KEY FK_Kunden_Altersklassen, DROP FOREIGN KEY FK_Kunden_Gender, AUTO_INCREMENT=1;
ALTER TABLE tbl_TransaktionsTypen AUTO_INCREMENT=1;
ALTER TABLE tbl_ProduktTypen AUTO_INCREMENT=1;
ALTER TABLE tbl_Kontinenten AUTO_INCREMENT=1;
ALTER TABLE tbl_Portfolios AUTO_INCREMENT=1;
ALTER TABLE tbl_Gender AUTO_INCREMENT=1;
ALTER TABLE tbl_Altersklassen AUTO_INCREMENT=1;

-- Truncate tables
TRUNCATE TABLE tbl_Transaktionen;
TRUNCATE TABLE tbl_TransaktionsTypen;
TRUNCATE TABLE tbl_Produkte;
TRUNCATE TABLE tbl_ProduktTypen;
TRUNCATE TABLE tbl_Boersen;
TRUNCATE TABLE tbl_Staedte;
TRUNCATE TABLE tbl_Laender;
TRUNCATE TABLE tbl_Kontinenten;
TRUNCATE TABLE tbl_KundenPortfolio;
TRUNCATE TABLE tbl_Kunden;
TRUNCATE TABLE tbl_Portfolios;
TRUNCATE TABLE tbl_Kundentypen;
TRUNCATE TABLE tbl_Altersklassen;
TRUNCATE TABLE tbl_Gender;
TRUNCATE TABLE tbl_Rating;
TRUNCATE TABLE tbl_RatingKategorien;



-- Populate tbl_Gender
INSERT INTO tbl_Gender (GenderID, Gender)
VALUES
    ('M', 'Male'),
    ('F', 'Female');

-- Populate tbl_Altersklassen
INSERT INTO tbl_Altersklassen (Altersklasse, Beschreibung)
VALUES
    ('18-24', 'Alter zwischen 18-24'),
--    ('25-34', 'Alter zwischen 25-34'),
--    ('35-44', 'Alter zwischen 35-44'),
--    ('45-54', 'Alter zwischen 45-54'),
    ('55+', 'Alter 55 und höher');

-- Populate tbl_Kundentypen
INSERT INTO tbl_Kundentypen (KundentypID, Beschreibung)
VALUES
    ('Privat', 'Privatkunde'),
    ('Business', 'Geschäftskunde');

-- Populate tbl_Kunden
INSERT INTO tbl_Kunden (KundentypID, AltersklasseID, GenderID, Kunden_Beschreibung)
VALUES
	('Privat', 1, 'M', 'John Doe'),
--    ('Privat', 2, 'F', 'Jane Smith'),
--    ('Business', 3, 'M', 'James Brown'),
--    ('Privat', 4, 'F', 'Emily Johnson'),
--    ('Business', 5, 'M', 'Robert Williams'),
--    ('Business', 3, 'F', 'Sophia Jones'),
--    ('Privat', 2, 'M', 'Michael Davis'),
    ('Business', 2, 'F', 'Olivia Martinez'),
--    ('Business', 3, 'M', 'William Taylor'),
    ('Privat', 2, 'F', 'Emma Anderson');
    

-- Populate tbl_Portfolios
INSERT INTO tbl_Portfolios (Beschreibung)
VALUES
    ('Investment Portfolio 1'),
    ('Sparportfolio 1'),
 --   ('Pensionsportfolio'),
 --   ('High-Risk Portfolio'),
 --   ('Tech Stocks Portfolio'),
 --   ('International Investments'),
 --   ('Real Estate Portfolio'),
 --   ('Emerging Markets Portfolio'),
 --   ('Sustainable Investments'),
    ('Short-Term Holdings'),
    ('Diversified Growth Portfolio');

-- Populate tbl_KundenPortfolio
INSERT INTO tbl_KundenPortfolio (PortfolioID, KundenID)
VALUES
    (1, 1),
    (1, 2),
    (2, 3),
    (3, 1);  -- ,
  --  (4, 8),
  --  (5, 9),
   -- (6, 10),
   -- (7, 6),
  --  (8, 4),
  --  (9, 7),
   -- (10, 6),
   -- (11, 5);

-- Populate tbl_Kontinenten
INSERT INTO tbl_Kontinenten (Name)
VALUES
    ('Nord Amerika'),
    ('Europa'),
    ('Asien'),
    ('Australia');
    


-- Populate tbl_Laender
INSERT INTO tbl_Laender (Name, KontinentID)
VALUES
    ('USA', 1),
    ('Deutschland', 2),
    ('China', 3),
	('Kanada', 1),
    ('Großbritanien', 2),
    ('India', 3),
    ('Japan', 3),
    ('Australia', 4),
    ('France', 2);

-- Populate tbl_Staedte
INSERT INTO tbl_Staedte (Name, LandID)
VALUES
    ('New York', 1),
    ('Frankfurt', 2),
    ('Beijing', 3),
	('Toronto', 4),
    ('London', 5),
    ('Mumbai', 6),
    ('Tokyo', 7),
    ('Sydney', 8),
    ('Paris', 9);

-- Populate tbl_Boersen
INSERT INTO tbl_Boersen (BoersenID, Name, StadtID)
VALUES
    ('NYSE', 'New York Stock Exchange', 1),
    ('FWB', 'Frankfurt Stock Exchange', 2),
--    ('SSE', 'Shanghai Stock Exchange', 3),
    ('NASDAQ', 'Nasdaq NY', 1);  -- ,
--    ('TSX', 'Toronto Stock Exchange', 4),
--    ('LSE', 'London Stock Exchange', 6),
--    ('BSE', 'Bombay Stock Exchange', 6),
--    ('TSE', 'Tokyo Stock Exchange', 7),
--    ('ASX', 'Australian Securities Exchange', 8),
--    ('Euronext', 'Euronext Paris', 9),
--    ('NYSE Arca', 'NYSE Arca', 1);

-- Populate tbl_ProduktTypen
INSERT INTO tbl_ProduktTypen (Beschreibung)
VALUES
    ('Stocks'),
    ('Bonds'),
    ('Mutual Funds');

-- Populate tbl_Rating_Kategorien
INSERT INTO tbl_RatingKategorien (Rating_Kategorie, Beschreibung)
VALUES
    ('A', 'Sichere Anlagen'),
    ('B', 'Wachstumskandidaten'),
    ('C', 'Anlagen mit erhöhtem Risiko');
    
-- Populate tbl_Rating
INSERT INTO tbl_Rating (Rating, Rating_Kategorie)
VALUES
    ('A+', 'A'),
    ('A', 'A'),
    ('A-', 'A'),
    ('B+', 'B'),
    ('B', 'B'),
    ('B-', 'B'),
    ('C+', 'C'),
    ('C', 'C'),
    ('C-', 'C');

-- Populate tbl_Produkte
INSERT INTO tbl_Produkte (ProduktID, Produkt_Beschreibung, ProduktTypID, BoersenID, Rating)
VALUES
    ('AAPL', 'Apple Inc. Stock', 1, 'NYSE', 'A+'),
    ('GOOG', 'Alphabet Inc. Stock', 1, 'NASDAQ', 'A'),
    ('X03G.DE', 'German Government Bond', 2, 'FWB', 'A-'),
--    ('AMZN', 'Amazon.com Inc. Stock', 1, 'NASDAQ', 'A'),
--    ('MSFT', 'Microsoft Corporation Stock', 1, 'NASDAQ', 'A'),
--    ('BSE-500.BO', 'S&P BSE 500 INDEX', 3, 'BSE', 'C'),
--    ('6758.T', 'Sony Corporation Stock', 1, 'TSE', 'A-'),
--    ('BHP.AX', 'BHP Group Limited Stock', 1, 'ASX', 'B'),
--    ('UTEN', 'US Treasury Note 10 Years', 2, 'NASDAQ', 'B+'),
    ('FXAIX', 'Fidelity Index Fund', 3, 'NASDAQ', 'B+');

-- Populate tbl_TransaktionsTypen
INSERT INTO tbl_TransaktionsTypen (Typ)
VALUES
    ('Buy'),
    ('Sell');

-- Populate tbl_Transaktionen

-- CREATE Procedure fill Trasaktionen

DELIMITER //
DROP PROCEDURE IF EXISTS usp_Fill_Transaktionen2;
CREATE PROCEDURE usp_Fill_Transaktionen2()
BEGIN
  DECLARE i INT DEFAULT 0;
  DECLARE Port_i INT DEFAULT 1;
  DECLARE maxPortfolioID INT;
  DECLARE maxProduktIndex INT;
  DECLARE randomPortfolioID INT;
  DECLARE randomProduktIndex INT;
  DECLARE randomDate DATETIME;

        
  SELECT MAX(PortfolioID) INTO maxPortfolioID FROM tbl_Portfolios;
  SELECT COUNT(*) INTO maxProduktIndex FROM tbl_Produkte;
  
  WHILE Port_i <= maxPortfolioID DO 
    INSERT INTO tbl_Transaktionen (PortfolioID, ProduktID, Zeitstempel, Preis, Anzahl, TransaktionsTypID)
    VALUES 
   --   (Port_i, '6758.T', '2021-01-01', 200, 100, 1),
   --   (Port_i, 'UTEN', '2021-01-01', 200, 100, 1),
   --   (Port_i, 'MSFT', '2021-01-01', 200, 100, 1),
      (Port_i, 'GOOG', '2021-01-01', 200, 100, 1),
      (Port_i, 'FXAIX', '2021-01-01', 200, 100, 1),
   --   (Port_i, 'BSE-500.BO', '2021-01-01', 200, 100, 1),
   --   (Port_i, 'BHP.AX', '2021-01-01', 200, 100, 1),
   --   (Port_i, 'AMZN', '2021-01-01', 200, 100, 1),
      (Port_i, 'AAPL', '2021-01-01', 200, 100, 1),
      (Port_i, 'X03G.DE', '2021-01-01', 200, 100, 1);
    
    SET Port_i = Port_i + 1;
  END WHILE;
  
  WHILE i < 100 DO
    SET randomPortfolioID = FLOOR(RAND() * maxPortfolioID) + 1;
    SET randomProduktIndex = FLOOR(RAND() * maxProduktIndex);
    SET randomDate = DATE_ADD(NOW(), INTERVAL -FLOOR(RAND() * 0) YEAR);
--    SET randomDate = DATE_ADD(randomDate, INTERVAL -FLOOR(RAND() * 12) MONTH);
    SET randomDate = DATE_ADD(randomDate, INTERVAL -FLOOR(RAND() * 365) DAY);
    
    INSERT INTO tbl_Transaktionen (PortfolioID, ProduktID, Zeitstempel, Preis, Anzahl, TransaktionsTypID)
    SELECT
      randomPortfolioID,
      ProduktID,
      randomDate,
      ROUND(RAND() * 200 + 100, 2),
      FLOOR(RAND() * 10) + 1,
      FLOOR(RAND() * 2) + 1
    FROM tbl_Produkte
    LIMIT randomProduktIndex, 1;
    
    SET i = i + 1;
  END WHILE;
END;
//
DELIMITER ;

#CALL usp_fill_Transaktionen;
CALL usp_fill_Transaktionen2;
    
    -- Add back foreign key constraints
ALTER TABLE tbl_KundenPortfolio ADD CONSTRAINT FK_KundenPortfolios_Portfolios FOREIGN KEY (PortfolioID) REFERENCES tbl_Portfolios (PortfolioID);
ALTER TABLE tbl_KundenPortfolio ADD CONSTRAINT FK_KundenPortfolios_Kunden FOREIGN KEY (KundenID) REFERENCES tbl_Kunden (KundenID);
ALTER TABLE tbl_Transaktionen ADD CONSTRAINT FK_Transaktionen_Portfolios FOREIGN KEY (PortfolioID) REFERENCES tbl_Portfolios (PortfolioID);
ALTER TABLE tbl_Transaktionen ADD CONSTRAINT FK_Transaktionen_Produkte FOREIGN KEY (ProduktID) REFERENCES tbl_Produkte (ProduktID);
ALTER TABLE tbl_Transaktionen ADD CONSTRAINT FK_Transaktionen_TransaktionsTypen FOREIGN KEY (TransaktionsTypID) REFERENCES tbl_TransaktionsTypen (TransaktionsTypID);
ALTER TABLE tbl_Produkte ADD CONSTRAINT FK_Produkte_Boersen FOREIGN KEY (BoersenID) REFERENCES tbl_Boersen (BoersenID);
ALTER TABLE tbl_Produkte ADD CONSTRAINT FK_Produkte_Produkttypen FOREIGN KEY (ProdukttypID) REFERENCES tbl_Produkttypen (ProdukttypID);
ALTER TABLE tbl_Produkte ADD CONSTRAINT FK_Produkte_Rating FOREIGN KEY (Rating) REFERENCES tbl_Rating (Rating);
ALTER TABLE tbl_Rating ADD CONSTRAINT FK_Rating_RatingKategorien FOREIGN KEY (Rating_Kategorie) REFERENCES tbl_RatingKategorien (Rating_Kategorie);
ALTER TABLE tbl_Staedte ADD CONSTRAINT FK_Staedte_Laender FOREIGN KEY (LandID) REFERENCES tbl_Laender (LandID);
ALTER TABLE tbl_Boersen ADD CONSTRAINT FK_Boersen_Staedte FOREIGN KEY (StadtID) REFERENCES tbl_Staedte (StadtID);
ALTER TABLE tbl_Laender ADD CONSTRAINT FK_Laender_Kontinente FOREIGN KEY (KontinentID) REFERENCES tbl_Kontinenten (KontinentID);
ALTER TABLE tbl_Kunden ADD CONSTRAINT FK_Kunden_Kundentypen FOREIGN KEY (KundentypID) REFERENCES tbl_Kundentypen (KundentypID);
ALTER TABLE tbl_Kunden ADD CONSTRAINT FK_Kunden_Altersklassen FOREIGN KEY (AltersklasseID) REFERENCES tbl_Altersklassen (AltersklasseID);
ALTER TABLE tbl_Kunden ADD CONSTRAINT FK_Kunden_Gender FOREIGN KEY (GenderID) REFERENCES tbl_Gender (GenderID);
