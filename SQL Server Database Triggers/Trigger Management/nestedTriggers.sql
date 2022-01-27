USE KinetEcoTRG;
GO

CREATE TABLE dbo.FirstTable (
    RowID int IDENTITY PRIMARY KEY,
    RowValue nvarchar(50)
);
GO

CREATE TABLE dbo.SecondTable (
    RowID int IDENTITY PRIMARY KEY,
    EventDate datetime2
);
GO

CREATE TRIGGER dbo.NestedExample
ON dbo.FirstTable
AFTER INSERT
AS
    INSERT INTO dbo.SecondTable (EventDate)
    VALUES (GETDATE())
;
GO

CREATE TRIGGER dbo.NestedExample2
ON dbo.SecondTable
AFTER INSERT
AS
    PRINT 'The second trigger fired'
;
GO

INSERT INTO dbo.FirstTable (RowValue)
VALUES ('Elephant');

SELECT * FROM FirstTable;
SELECT * FROM SecondTable;

sp_configure;

EXEC sp_configure 'Nested Triggers', 0;
RECONFIGURE;

INSERT INTO dbo.FirstTable (RowValue)
VALUES ('Kangaroo');

SELECT * FROM FirstTable;
SELECT * FROM SecondTable;

EXEC sp_configure 'Nested Triggers', 1;
RECONFIGURE;

DROP TABLE IF EXISTS dbo.FirstTable;
DROP TABLE IF EXISTS dbo.SecondTable;
