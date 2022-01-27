USE KinetEcoTRG;
GO

CREATE TABLE dbo.TableEventCapture (
    EventType nvarchar(100),
    PostTime nvarchar(100),
    SPID nvarchar(100),
    ServerName nvarchar(100),
    LoginName nvarchar(100),
    UserName nvarchar(100),
    DatabaseName nvarchar(100),
    SchemaName nvarchar(100),
    ObjectName nvarchar(100),
    ObjectType nvarchar(100),
    TSQLCommand nvarchar(2000)
);
GO

CREATE OR ALTER TRIGGER TableCreateEvent
ON DATABASE
FOR CREATE_TABLE
AS
INSERT dbo.TableEventCapture
   (EventType,
    PostTime,
    SPID,
    ServerName,
    LoginName,
    UserName,
    DatabaseName,
    SchemaName,
    ObjectName,
    ObjectType,
    TSQLCommand)
VALUES (
    EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'nvarchar(100)'),
    EVENTDATA().value('(/EVENT_INSTANCE/PostTime)[1]', 'nvarchar(100)'),
    EVENTDATA().value('(/EVENT_INSTANCE/SPID)[1]', 'nvarchar(100)'),
    EVENTDATA().value('(/EVENT_INSTANCE/ServerName)[1]', 'nvarchar(100)'),
    EVENTDATA().value('(/EVENT_INSTANCE/LoginName)[1]', 'nvarchar(100)'),
    EVENTDATA().value('(/EVENT_INSTANCE/UserName)[1]', 'nvarchar(100)'),
    EVENTDATA().value('(/EVENT_INSTANCE/DatabaseName)[1]', 'nvarchar(100)'),
    EVENTDATA().value('(/EVENT_INSTANCE/SchemaName)[1]', 'nvarchar(100)'),
    EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'nvarchar(100)'),
    EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]', 'nvarchar(100)'),
    EVENTDATA().value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'nvarchar(2000)')
);
GO

CREATE TABLE dbo.Test (
TestID int IDENTITY PRIMARY KEY
);
GO

SELECT * FROM dbo.TableEventCapture;
GO

DROP TRIGGER TableCreateEvent
ON DATABASE;
DROP TABLE dbo.TableEventCapture;
DROP TABLE dbo.Test;
GO
