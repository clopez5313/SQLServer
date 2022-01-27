USE KinetEcoTRG;
GO

CREATE TABLE dbo.Value (
    RowID int IDENTITY PRIMARY KEY,
    RowValue int
);
GO

CREATE TABLE dbo.Sequence (
    RowID int IDENTITY PRIMARY KEY,
    RowSequence nvarchar(20)
);
GO

CREATE TRIGGER dbo.TriggerA
ON dbo.Value
AFTER INSERT
AS
INSERT INTO dbo.Sequence (RowSequence) VALUES ('Trigger A Fired')
;
GO

CREATE TRIGGER dbo.TriggerB
ON dbo.Value
AFTER INSERT
AS
INSERT INTO dbo.Sequence (RowSequence) VALUES ('Trigger B Fired')
;
GO

CREATE TRIGGER dbo.TriggerC
ON dbo.Value
AFTER INSERT
AS
INSERT INTO dbo.Sequence (RowSequence) VALUES ('Trigger C Fired')
;
GO

INSERT INTO dbo.Value (RowValue)
VALUES (10);

SELECT * FROM dbo.Sequence;

sp_settriggerorder
    @triggername = 'TriggerC',
    @order = 'first',  -- or 'last' or 'none'
    @stmttype = 'INSERT'
;

DROP TABLE IF EXISTS dbo.Value;
DROP TABLE IF EXISTS dbo.Sequence;
