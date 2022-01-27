USE KinetEcoTRG;
GO

CREATE TABLE dbo.ProductCategories (
    CategoryID int IDENTITY PRIMARY KEY,
    CategoryName nvarchar(20),
    CreationDate datetime2,
    LastModifiedDate datetime2
);
GO

/* INSERT YOUR SOLUTION HERE */
CREATE TRIGGER dbo.CategoryInsert
ON dbo.ProductCategories
AFTER INSERT
AS
UPDATE dbo.ProductCategories
	SET CreationDate = GETDATE()
	FROM Inserted
	WHERE dbo.ProductCategories.CategoryID = Inserted.CategoryID
;
GO

CREATE TRIGGER dbo.CategoryUpdate
ON dbo.ProductCategories
AFTER UPDATE
AS
UPDATE dbo.ProductCategories
	SET LastModifiedDate = GETDATE()
	FROM Inserted
	WHERE dbo.ProductCategories.CategoryID = Inserted.CategoryID
;
GO

CREATE TRIGGER dbo.CategoryDelete
ON dbo.ProductCategories
INSTEAD OF DELETE
AS
ROLLBACK
;
GO




/* TEST SOLUTION */
INSERT INTO dbo.ProductCategories (CategoryName)
VALUES
    ('Solar Panel'), ('Battery'), ('Wind Harvester')
;

UPDATE dbo.ProductCategories
SET CategoryName = 'Wind Turbine'
WHERE CategoryID = 3
;

DELETE FROM dbo.ProductCategories
WHERE CategoryID = 2;

SELECT * FROM dbo.ProductCategories;

/* REMOVE ProductCategories TABLE WHEN COMPLETE */
DROP TABLE dbo.ProductCategories;
GO
