CREATE TABLE [dbo].[TASK_RECURRENCE_DAILY_20080101] (
    [TaskId]             BIGINT   NOT NULL,
    [TaskDailyTypeId]    INT      NULL,
    [TaskDailyFrequency] INT      NULL,
    [UpdatedDate]        DATETIME CONSTRAINT [DF_TASK_RECURRENCE_DAILY_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]          INT      CONSTRAINT [DF_TASK_RECURRENCE_DAILY_UpdatedBy] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_TASK_RECURRANCE_DAILY] PRIMARY KEY CLUSTERED ([TaskId] ASC)
);

