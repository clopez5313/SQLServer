USE KinetEcoTRG;
GO

CREATE TABLE dbo.NumberParity (
    RowID int IDENTITY PRIMARY KEY,
    MyNumber int,
    Parity nvarchar(20)
);
GO

CREATE TRIGGER dbo.ParityTest
ON dbo.NumberParity
AFTER INSERT
AS
SET NOCOUNT ON;
UPDATE dbo.NumberParity
        SET Parity = 'Even Number'
        FROM inserted
        WHERE dbo.NumberParity.RowID = inserted.RowID AND
            inserted.MyNumber % 2 = 0;
UPDATE dbo.NumberParity
        SET Parity = 'Odd Number'
        FROM inserted
        WHERE dbo.NumberParity.RowID = inserted.RowID AND
            inserted.MyNumber % 2 <> 0;
;
GO

INSERT INTO dbo.NumberParity (MyNumber)
VALUES
    (12), (23), (16), (22), (43)
;

SELECT * FROM dbo.NumberParity;

INSERT INTO dbo.NumberParity (MyNumber, Parity)
VALUES
    (99, 'Even Number')
;

SELECT * FROM dbo.NumberParity;

DROP TABLE dbo.NumberParity;
GO
