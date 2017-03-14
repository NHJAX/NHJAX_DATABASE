CREATE TYPE [dbo].[AuditLogType] AS TABLE (
    [AuditTypeId]     INT            NULL,
    [TargetTableName] NVARCHAR (255) NULL,
    [TargetRecordId]  INT            NULL,
    [DataBefore]      XML            NULL,
    [DataAfter]       XML            NULL,
    [EntryDate]       DATETIME       NULL,
    [UserId]          INT            NULL);

