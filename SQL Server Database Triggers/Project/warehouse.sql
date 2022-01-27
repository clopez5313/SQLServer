-- Objective: Increase the QuantityOnHand of Products when shipments received by the Warehouse
USE KinetEcoInventory;
GO

-- Review the starting state of the tables
SELECT * FROM dbo.Products;
SELECT * FROM dbo.WarehouseReceiving;
GO

-- Create a trigger that adds QuantityOnHand to Products when received by the Warehouse
CREATE TRIGGER dbo.RestockProducts
ON dbo.WarehouseReceiving
AFTER INSERT
AS
SET NOCOUNT ON;
UPDATE dbo.Products
    SET QuantityOnHand += (SELECT Inserted.QuantityReceived FROM Inserted)
    FROM Inserted
    WHERE Inserted.ProductID = Products.ProductID;
;

-- Verify that the trigger functions as expected by
-- adding a row to the WarehouseReceiving table
SELECT * FROM dbo.Products;

INSERT INTO WarehouseReceiving (ProductID, QuantityReceived)
VALUES (1, 100);

SELECT * FROM dbo.WarehouseReceiving;
SELECT * FROM dbo.Products;
SELECT * FROM InventoryAudit;
