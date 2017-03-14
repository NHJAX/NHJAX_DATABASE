CREATE TABLE [dbo].[TASK_ASSIGNMENT_20080101] (
    [TaskAssignmentId] BIGINT   IDENTITY (1, 1) NOT NULL,
    [TaskId]           BIGINT   NULL,
    [TaskCreatedDate]  DATETIME CONSTRAINT [DF_Table_1_TaskPerformed] DEFAULT (getdate()) NULL,
    [TaskLockedDate]   DATETIME NULL,
    [TaskLockedBy]     INT      NULL,
    CONSTRAINT [PK_TASK_ASSIGNMENT] PRIMARY KEY CLUSTERED ([TaskAssignmentId] ASC)
);

