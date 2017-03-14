CREATE TABLE [dbo].[SHUTDOWN_PRIORITY] (
    [ShutdownPriorityId]   INT           NOT NULL,
    [ShutdownPriorityDesc] NVARCHAR (50) NULL,
    CONSTRAINT [PK_SHUTDOWN_PRIORITY] PRIMARY KEY CLUSTERED ([ShutdownPriorityId] ASC)
);

