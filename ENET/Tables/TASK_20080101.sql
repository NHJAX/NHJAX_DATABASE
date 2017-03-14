CREATE TABLE [dbo].[TASK_20080101] (
    [TaskId]           BIGINT        IDENTITY (1, 1) NOT NULL,
    [TaskDesc]         VARCHAR (150) NULL,
    [TaskRecurrenceId] INT           NULL,
    [CreatedDate]      DATETIME      CONSTRAINT [DF_WORK_TASK_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]      DATETIME      CONSTRAINT [DF_WORK_TASK_UpdatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]        INT           CONSTRAINT [DF_WORK_TASK_CreatedBy] DEFAULT ((0)) NULL,
    [UpdatedBy]        INT           CONSTRAINT [DF_WORK_TASK_UpdatedBy] DEFAULT ((0)) NULL,
    [Inactive]         BIT           CONSTRAINT [DF_WORK_TASK_Inactive] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_WORK_TASK] PRIMARY KEY CLUSTERED ([TaskId] ASC)
);

