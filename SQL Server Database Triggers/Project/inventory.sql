-- Set up the inventory management schema
CREATE DATABASE KinetEcoInventory;
GO
USE KinetEcoInventory;
GO

CREATE TABLE dbo.Products (
    ProductID int IDENTITY PRIMARY KEY,
    ProductName nvarchar(50),
    QuantityOnHand int,
    LastRestocked datetime2,
    LastSold datetime2
);

CREATE TABLE dbo.InventoryAudit (
    AuditLogID int IDENTITY PRIMARY KEY,
    ProductID int,
    EventTimestamp datetime2,
    OldQuantity int,
    NewQuantity int
);

CREATE TABLE WarehouseReceiving (
    ReceiptID int IDENTITY PRIMARY KEY,
    ProductID int,
    QuantityReceived int
);

-- Add initial rows to the Products table
INSERT INTO dbo.Products (ProductName, QuantityOnHand)
VALUES ('Solar Charger', 0), ('Wind Turbine', 0), ('Emergency Radio', 0), ('Rechargable Battery', 0)
;

SELECT * FROM dbo.Products;
