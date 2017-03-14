CREATE TABLE [dbo].[TASK_RECURRENCE_WEEKLY_20080101] (
    [TaskId]              BIGINT   NOT NULL,
    [TaskWeeklyFrequency] INT      NULL,
    [TaskWeeklySunday]    BIT      CONSTRAINT [DF_TASK_RECURRANCE_WEEKLY_TaskWeeklySunday] DEFAULT ((0)) NULL,
    [TaskWeeklyMonday]    BIT      CONSTRAINT [DF_TASK_RECURRANCE_WEEKLY_TaskWeeklyMonday] DEFAULT ((0)) NULL,
    [TaskWeeklyTuesday]   BIT      CONSTRAINT [DF_TASK_RECURRANCE_WEEKLY_TaskWeeklyTuesday] DEFAULT ((0)) NULL,
    [TaskWeeklyWednesday] BIT      CONSTRAINT [DF_TASK_RECURRANCE_WEEKLY_TaskWeeklyWednesday] DEFAULT ((0)) NULL,
    [TaskWeeklyThursday]  BIT      CONSTRAINT [DF_TASK_RECURRANCE_WEEKLY_TaskWeeklyThursday] DEFAULT ((0)) NULL,
    [TaskWeeklyFriday]    BIT      CONSTRAINT [DF_TASK_RECURRANCE_WEEKLY_TaskWeeklyFriday] DEFAULT ((0)) NULL,
    [TaskWeeklySaturday]  BIT      CONSTRAINT [DF_TASK_RECURRANCE_WEEKLY_TaskWeeklySaturday] DEFAULT ((0)) NULL,
    [UpdatedDate]         DATETIME CONSTRAINT [DF_TASK_RECURRANCE_WEEKLY_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]           INT      CONSTRAINT [DF_TASK_RECURRANCE_WEEKLY_UpdatedBy] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_TASK_RECURRANCE_WEEKLY] PRIMARY KEY CLUSTERED ([TaskId] ASC)
);

