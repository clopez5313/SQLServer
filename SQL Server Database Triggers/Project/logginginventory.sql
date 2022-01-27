-- Objective: Add a new row to InventoryAudit any time a change is made
-- to the quantity of products on hand.
USE KinetEcoInventory;
GO

-- Review the starting state of both tables
SELECT * FROM dbo.Products;
SELECT * FROM dbo.InventoryAudit;
GO

-- Create the trigger that logs changes to Product.QuantityOnHand
CREATE TRIGGER dbo.InventoryChangeLog
ON dbo.Products
AFTER UPDATE
AS
SET NOCOUNT ON;
IF UPDATE(QuantityOnHand)
    INSERT INTO dbo.InventoryAudit (ProductID, EventTimestamp, OldQuantity, NewQuantity)
    VALUES (
        (SELECT Inserted.ProductID FROM Inserted),
        GETDATE(),
        (SELECT Deleted.QuantityOnHand FROM Deleted),
        (SELECT Inserted.QuantityOnHand FROM Inserted)
    );
;

-- Verify that the trigger functions as expected
UPDATE dbo.Products SET QuantityOnHand = 5
WHERE ProductID = 1;

SELECT * FROM Products;
SELECT * FROM dbo.InventoryAudit;

-- The trigger should not fire on INSERT events
-- or on UPDATE events that don't change QuantityOnHand
INSERT INTO dbo.Products (ProductName, QuantityOnHand)
VALUES ('AA Battery', 0);

UPDATE dbo.Products SET LastRestocked = GETDATE()
WHERE ProductID = 1;
