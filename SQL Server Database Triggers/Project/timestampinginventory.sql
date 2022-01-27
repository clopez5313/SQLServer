-- Objective: Update timestamps in the Products table when inventory levels change
USE KinetEcoInventory;
GO

-- Review the starting state of the table
SELECT * FROM dbo.Products;
GO

-- Create a trigger that updates both timestamps
CREATE TRIGGER dbo.ProductTimestamps
ON dbo.Products
AFTER UPDATE
AS
SET NOCOUNT ON;
IF (SELECT Inserted.QuantityOnHand FROM Inserted) < (SELECT Deleted.QuantityOnHand FROM Deleted)
    UPDATE dbo.Products
        SET LastSold = GETDATE()
        FROM Inserted
        WHERE Inserted.ProductID = Products.ProductID;
ELSE IF (SELECT Inserted.QuantityOnHand FROM Inserted) > (SELECT Deleted.QuantityOnHand FROM Deleted)
    UPDATE dbo.Products
        SET LastRestocked = GETDATE()
        FROM Inserted
        WHERE Inserted.ProductID = Products.ProductID;
;

-- Verify that the trigger functions as expected by
-- increasing and decreasing the QuantityOnHand of product 3
SELECT * FROM dbo.Products;

UPDATE dbo.Products SET QuantityOnHand = 5
WHERE ProductID = 3;

UPDATE dbo.Products SET QuantityOnHand = 2
WHERE ProductID = 3;
