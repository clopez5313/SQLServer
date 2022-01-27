USE KinetEcoTRG;
GO

/* Create a trigger that fires on all table events.
   The trigger needs to save information from EVENTDATA()
   about these elements: EventType, UserName, ObjectName, TSQLCommand.

INSERT YOUR SOLUTION HERE */
CREATE TABLE dbo.ChallengeTwoEventCapture(
	EventID int IDENTITY PRIMARY KEY,
	EventTime datetime2,
	EventType nvarchar(100),
	UserName nvarchar(100),
	ObjectName nvarchar(100),
	TSQLCommand nvarchar(2000)
);

CREATE TRIGGER TableEventTrigger
ON DATABASE
FOR DDL_TABLE_EVENTS
AS
INSERT dbo.ChallengeTwoEventCapture (
	EventTime, EventType, UserName, ObjectName, TSQLCommand)
VALUES (
	GETDATE(),
	EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'nvarchar(100)'),
	EVENTDATA().value('(/EVENT_INSTANCE/UserName)[1]', 'nvarchar(100)'),
	EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'nvarchar(100)'),
	EVENTDATA().value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'nvarchar(2000)')
);


/* TEST SOLUTION */
CREATE TABLE dbo.SolutionTest (
    RowID int IDENTITY PRIMARY KEY
);
GO

ALTER TABLE dbo.SolutionTest ADD
    RowText nvarchar(20),
    RowNumber int
;
GO

ALTER TABLE dbo.SolutionTest DROP COLUMN RowNumber;

DROP TABLE dbo.SolutionTest;

/* VIEW RESULTS */
SELECT * FROM ChallengeTwoEventCapture;


/* CLEAN THE SERVER WHEN COMPLETE */
DROP TRIGGER {YourTriggerName}
ON DATABASE;
DROP TABLE {YourEventCaptureTableName};
GO
