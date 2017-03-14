CREATE TABLE [dbo].[LOGON_AUDITING] (
    [LogonAuditingId]    BIGINT        IDENTITY (1, 1) NOT NULL,
    [SessionId]          INT           NULL,
    [LogonTime]          DATETIME      NULL,
    [HostName]           VARCHAR (50)  NULL,
    [ProgramName]        VARCHAR (500) NULL,
    [LoginName]          VARCHAR (50)  NULL,
    [ClientHost]         VARCHAR (50)  NULL,
    [ConcurrentSessions] BIGINT        NULL,
    CONSTRAINT [PK_LOGON_AUDITING] PRIMARY KEY CLUSTERED ([LogonAuditingId] ASC)
);

