USE KinetEcoTRG;
GO

CREATE TABLE dbo.Inventory (
    InventoryID int IDENTITY PRIMARY KEY,
    InventoryName nvarchar(50)
);
GO

CREATE OR ALTER TRIGGER dbo.InventoryMessage
ON dbo.Inventory
AFTER INSERT
AS
PRINT 'The trigger has fired!'
;
GO

INSERT INTO dbo.Inventory (InventoryName)
VALUES
   ('Solar Powered Battery Charger');
GO

DISABLE TRIGGER dbo.InventoryMessage ON dbo.Inventory;
GO

INSERT INTO dbo.Inventory (InventoryName)
VALUES
   ('Portable Wind Generator');
GO

ENABLE TRIGGER dbo.InventoryMessage ON dbo.Inventory;
GO

INSERT INTO dbo.Inventory (InventoryName)
VALUES
   ('Solar Powered Emergency Radio');
GO

SELECT * FROM dbo.Inventory;

DROP TRIGGER IF EXISTS dbo.InventoryMessage;
DROP TABLE IF EXISTS dbo.Inventory;
