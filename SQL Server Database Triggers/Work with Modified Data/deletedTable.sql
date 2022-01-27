USE KinetEcoTRG;
GO

CREATE TABLE dbo.Vendors (
    VendorID int IDENTITY PRIMARY KEY,
    VendorName nvarchar(50)
);

CREATE TABLE dbo.VendorArchive (
    VendorID int PRIMARY KEY,
    VendorName nvarchar(50),
    DateArchived datetime2
);
GO

INSERT INTO dbo.Vendors
    VALUES ('KinetEco')
;
GO

CREATE TRIGGER dbo.ArchiveVendors
ON dbo.Vendors
AFTER DELETE
AS
SET NOCOUNT ON;
INSERT INTO VendorArchive (VendorID, VendorName)
    SELECT deleted.VendorID, deleted.VendorName
    FROM deleted;
UPDATE VendorArchive
    SET DateArchived = GETDATE()
    FROM deleted
    WHERE VendorArchive.VendorID = deleted.VendorID;
;
GO

SELECT * FROM Vendors;
GO

DELETE FROM dbo.Vendors
    WHERE VendorID = 1;
GO

SELECT * FROM Vendors;
GO
SELECT * FROM VendorArchive;
GO

DROP TABLE dbo.Vendors;
DROP TABLE dbo.VendorArchive;
GO
