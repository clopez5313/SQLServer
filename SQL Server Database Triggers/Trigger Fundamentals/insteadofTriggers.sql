USE KinetEcoTRG;
GO

CREATE TABLE dbo.AccountsPayable (
    AccountID int PRIMARY KEY,
    AccountNumber nvarchar(20)
);
GO

INSERT INTO dbo.AccountsPayable VALUES
    (1, '98016'), (2, '32408'), (3, '32984')
;
GO

SELECT * FROM dbo.AccountsPayable;
GO

CREATE OR ALTER TRIGGER dbo.AccountsDelete
ON dbo.AccountsPayable
INSTEAD OF DELETE
AS
ROLLBACK
;
GO

DELETE FROM dbo.AccountsPayable
WHERE AccountID = 1;
GO

SELECT * FROM dbo.AccountsPayable;
GO

DROP TABLE dbo.AccountsPayable;
GO
