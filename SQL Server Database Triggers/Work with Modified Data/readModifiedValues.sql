USE KinetEcoTRG;
GO

CREATE TABLE dbo.Colors (
    ColorID int IDENTITY PRIMARY KEY,
    ColorName nvarchar(20)
);
GO

CREATE TRIGGER dbo.TriggerTables
ON dbo.Colors
AFTER INSERT, UPDATE, DELETE
AS
SET NOCOUNT ON;
SELECT * FROM Inserted;
SELECT * FROM Deleted;
;
GO

INSERT INTO dbo.Colors (ColorName)
VALUES
    ('Red'), ('Green'), ('Blue')
;

UPDATE dbo.Colors
SET ColorName = 'Yellow'
WHERE ColorID = 3;

DELETE FROM dbo.Colors
WHERE ColorID = 2;

SELECT * FROM dbo.Colors;

DROP TABLE dbo.Colors;
GO
