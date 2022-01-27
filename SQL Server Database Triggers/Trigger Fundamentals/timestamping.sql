USE KinetEcoTRG;
GO

CREATE TABLE dbo.Customers (
    CustomerID int PRIMARY KEY,
    CustomerName nvarchar(50),
    LastModified datetime2
);
GO

CREATE OR ALTER TRIGGER dbo.CustomersModified
ON dbo.Customers
AFTER INSERT, UPDATE
AS
UPDATE dbo.Customers
  SET LastModified = GETDATE()
  FROM Inserted
  WHERE dbo.Customers.CustomerID = Inserted.CustomerID
;
GO

INSERT INTO dbo.Customers (CustomerID, CustomerName)
VALUES
   (1, 'Adam')
;
GO

SELECT * FROM dbo.Customers;

UPDATE dbo.Customers
SET CustomerName = 'Alan'
WHERE CustomerID = 1
;
GO

INSERT INTO dbo.Customers (CustomerID, CustomerName)
VALUES
   (2, 'Chandra'), (3, 'Madelynn');
GO

DROP TABLE dbo.Customers;
