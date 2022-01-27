USE KinetEcoTRG;
GO

CREATE TABLE dbo.Numbers (
    RowID int IDENTITY PRIMARY KEY,
    RowValue int
);
GO

CREATE TRIGGER dbo.RecursiveExample
ON dbo.Numbers
AFTER INSERT
AS
BEGIN
IF (SELECT TOP 1 Inserted.RowValue FROM Inserted) < 20
    INSERT INTO dbo.Numbers (RowValue)
    VALUES ((SELECT TOP 1 Inserted.RowValue FROM Inserted)+1)
ELSE PRINT 'Trigger Recursion Completed'
END
;
GO

INSERT INTO dbo.Numbers (RowValue)
VALUES (10);

SELECT * FROM Numbers;

SELECT name, is_recursive_triggers_on FROM sys.databases;

ALTER DATABASE KinetEcoTRG
SET RECURSIVE_TRIGGERS ON;

DROP TABLE IF EXISTS dbo.Numbers;
