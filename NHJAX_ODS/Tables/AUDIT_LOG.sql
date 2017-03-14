CREATE TABLE [dbo].[AUDIT_LOG] (
    [ODSEntryId]      INT            IDENTITY (1, 1) NOT NULL,
    [AuditTypeId]     INT            NOT NULL,
    [TargetTableName] NVARCHAR (255) NOT NULL,
    [TargetRecordId]  INT            NOT NULL,
    [DataBefore]      XML            NULL,
    [DataAfter]       XML            NULL,
    [EntryDate]       DATETIME       CONSTRAINT [DF_AUDIT_LOG_EntryData] DEFAULT (getdate()) NOT NULL,
    [UserId]          INT            NOT NULL,
    CONSTRAINT [PK_AUDIT_LOG] PRIMARY KEY CLUSTERED ([ODSEntryId] ASC)
);

