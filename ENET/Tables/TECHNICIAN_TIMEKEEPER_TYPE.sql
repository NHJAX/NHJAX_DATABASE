CREATE TABLE [dbo].[TECHNICIAN_TIMEKEEPER_TYPE] (
    [TechnicianTimekeeperTypeId] INT      IDENTITY (1, 1) NOT NULL,
    [UserId]                     INT      NULL,
    [TimekeeperTypeId]           INT      NULL,
    [AudienceId]                 BIGINT   NULL,
    [CreatedDate]                DATETIME CONSTRAINT [DF_TECHNICIAN_TIMEKEEPER_TYPE_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]                  INT      CONSTRAINT [DF_TECHNICIAN_TIMEKEEPER_TYPE_CreatedBy] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_TECHNICIAN_TIMEKEEPER_TYPE] PRIMARY KEY CLUSTERED ([TechnicianTimekeeperTypeId] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_TECHNICIAN_TIMEKEEPER_TYPE_MultiKey]
    ON [dbo].[TECHNICIAN_TIMEKEEPER_TYPE]([UserId] ASC, [TimekeeperTypeId] ASC, [AudienceId] ASC);

