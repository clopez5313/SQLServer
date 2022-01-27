USE KinetEcoTRG;
GO

CREATE OR ALTER TRIGGER PreventTableAlterations
ON DATABASE
FOR ALTER_TABLE
AS
PRINT 'A trigger is cancelling all ALTER TABLE statements.';
ROLLBACK;
GO

CREATE TABLE dbo.People (
    PersonName nvarchar(20)
);
GO

ALTER TABLE dbo.People ALTER COLUMN PersonName nvarchar(100);

DROP TRIGGER PreventTableAlterations
ON DATABASE;
DROP TABLE dbo.People;
GO
