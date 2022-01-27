USE KinetEcoTRG;
GO

CREATE TABLE dbo.Products (
    ProductID int PRIMARY KEY,
    ProductName nvarchar(50)
);
GO

INSERT INTO dbo.Products
VALUES
   (5, 'D Battery'), (6, 'AA Rechargeable Battery');
GO

CREATE OR ALTER TRIGGER dbo.ProductMessage
ON dbo.Products
AFTER INSERT
AS
PRINT 'New product data has been inserted.'
;
GO

SELECT * FROM dbo.Products;

DROP TRIGGER IF EXISTS dbo.ProductMessage;
DROP TABLE dbo.Products;
