USE dwh_alfabank;

DROP TABLE IF EXISTS dwh_alfabank.dwh_log_CDC_FactTable;
CREATE TABLE dwh_alfabank.dwh_log_CDC_FactTable(
	dim_ZeitID char(8) NOT NULL,
    Datum_Aktualisierung datetime NOT NULL,
    Kommentar varchar(255));

DELIMITER //
CREATE TRIGGER tr_dwh_FactTable_update
AFTER UPDATE ON dwh_alfabank.dwh_FactTable FOR EACH ROW
BEGIN
    DECLARE updated_dim_ZeitID char(8);
    SET updated_dim_ZeitID = NEW.dim_ZeitID;

    -- Insert the updated dim_ZeitID into the log table
    INSERT IGNORE INTO dwh_alfabank.dwh_log_CDC_FactTable (dim_ZeitID, Datum_Aktualisierung, Kommentar)
    VALUES (updated_dim_ZeitID, NOW(), 'Update erfolgreich');
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER tr_dwh_FactTable_test2_update
AFTER UPDATE ON dwh_alfabank.dwh_FactTable_test2 FOR EACH ROW
BEGIN
    DECLARE updated_dim_ZeitID char(8);
    SET updated_dim_ZeitID = NEW.dim_ZeitID;

    -- Insert the updated dim_ZeitID into the log table
    INSERT INTO dwh_alfabank.dwh_log_CDC_FactTable (dim_ZeitID, Datum_Aktualisierung, Kommentar)
    VALUES (updated_dim_ZeitID, NOW(), 'TEST Update erfolgreich');
END;
//
DELIMITER ;