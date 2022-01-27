SELECT * FROM sys.triggers;

SELECT * FROM sys.trigger_events;

-- VIEW DETAILS ABOUT ALL DML TRIGGERS
SELECT
    sys.triggers.object_id AS [Object ID],
    sys.schemas.name AS [Schema],
    sys.objects.name AS [Table],
    sys.triggers.name AS [Trigger Name],
    sys.triggers.parent_class_desc AS [Parent],
    CASE (sys.triggers.is_instead_of_trigger )
        WHEN 0 THEN 'AFTER'
        WHEN 1 THEN 'INSTEAD OF'
    END AS [Trigger Type],
    sys.trigger_events.type_desc AS [Event],
    CASE (sys.triggers.is_disabled)
        WHEN 0 THEN 'Enabled'
        WHEN 1 THEN 'Disabled'
    END AS [Trigger State]
FROM sys.triggers JOIN sys.trigger_events On sys.triggers.object_id = sys.trigger_events.object_id
    JOIN sys.objects ON sys.triggers.parent_id = sys.objects.object_id
    JOIN sys.schemas ON sys.objects.schema_id = sys.schemas.schema_id
WHERE sys.triggers.parent_class = 1


-- VIEW DETAILS ABOUT ALL DDL TRIGGERS
SELECT
    sys.triggers.object_id AS [Object ID],
    sys.triggers.name AS [Trigger Name],
    sys.triggers.parent_class_desc AS [Parent],
    sys.trigger_events.type_desc AS [Event],
    sys.trigger_events.event_group_type_desc AS [Event Group],
    CASE (sys.triggers.is_disabled)
        WHEN 0 THEN 'Enabled'
        WHEN 1 THEN 'Disabled'
    END AS [Trigger State]
FROM sys.triggers JOIN sys.trigger_events On sys.triggers.object_id = sys.trigger_events.object_id
WHERE sys.triggers.parent_class = 0
