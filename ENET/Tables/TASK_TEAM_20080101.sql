CREATE TABLE [dbo].[TASK_TEAM_20080101] (
    [TaskTeamId]   BIGINT       IDENTITY (1, 1) NOT NULL,
    [TaskTeamDesc] VARCHAR (50) NULL,
    [CreatedDate]  DATETIME     CONSTRAINT [DF_TASK_TEAM_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]    INT          CONSTRAINT [DF_TASK_TEAM_CreatedBy] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_TASK_TEAM] PRIMARY KEY CLUSTERED ([TaskTeamId] ASC)
);

