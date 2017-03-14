CREATE TABLE [dbo].[PRIORITY] (
    [PriorityId]   BIGINT       IDENTITY (0, 1) NOT NULL,
    [PriorityDesc] VARCHAR (30) NULL,
    [CreatedDate]  DATETIME     CONSTRAINT [DF_PRIORITY_CreatedDate] DEFAULT (getdate()) NULL,
    [PriorityCode] VARCHAR (1)  NULL,
    CONSTRAINT [PK_PRIORITY] PRIMARY KEY CLUSTERED ([PriorityId] ASC)
);

