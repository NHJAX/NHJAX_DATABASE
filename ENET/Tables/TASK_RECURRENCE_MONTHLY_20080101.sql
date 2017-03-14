CREATE TABLE [dbo].[TASK_RECURRENCE_MONTHLY_20080101] (
    [TaskId]               BIGINT   NOT NULL,
    [TaskMonthlyTypeId]    INT      NULL,
    [TaskMonthlyFrequency] INT      NULL,
    [TaskMonthlyDay]       INT      NULL,
    [TaskMonthlyWeek]      INT      NULL,
    [TaskMonthlyWeekday]   INT      NULL,
    [UpdatedDate]          DATETIME CONSTRAINT [DF_TASK_RECURRENCE_MONTHLY_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]            INT      CONSTRAINT [DF_TASK_RECURRENCE_MONTHLY_UpdatedBy] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_TASK_RECURRENCE_MONTHLY] PRIMARY KEY CLUSTERED ([TaskId] ASC)
);

