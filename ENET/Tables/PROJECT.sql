CREATE TABLE [dbo].[PROJECT] (
    [ProjectId]   INT          IDENTITY (1, 1) NOT NULL,
    [ProjectDesc] VARCHAR (50) NULL,
    [CreatedDate] DATETIME     CONSTRAINT [DF_PROJECT_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]   BIGINT       CONSTRAINT [DF_PROJECT_CreatedBy] DEFAULT ((0)) NULL,
    [UpdatedDate] DATETIME     CONSTRAINT [DF_PROJECT_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]   BIGINT       CONSTRAINT [DF_PROJECT_UpdatedBy] DEFAULT ((0)) NULL,
    [Inactive]    BIT          CONSTRAINT [DF_PROJECT_Inactive] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_PROJECT] PRIMARY KEY CLUSTERED ([ProjectId] ASC)
);

