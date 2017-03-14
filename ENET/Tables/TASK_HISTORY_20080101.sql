CREATE TABLE [dbo].[TASK_HISTORY_20080101] (
    [TaskHistoryId]    BIGINT   IDENTITY (1, 1) NOT NULL,
    [TaskAssignmentId] BIGINT   NULL,
    [TaskChangedBy]    INT      NULL,
    [TaskChangedDate]  DATETIME NULL,
    [TaskActionId]     INT      NULL,
    CONSTRAINT [PK_TASK_HISTORY] PRIMARY KEY CLUSTERED ([TaskHistoryId] ASC)
);

