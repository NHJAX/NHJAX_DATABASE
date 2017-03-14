CREATE TABLE [dbo].[RELEASE_CONDITION] (
    [ReleaseConditionId]   BIGINT       NULL,
    [ReleaseConditionDesc] VARCHAR (30) NULL,
    [CreatedDate]          DATETIME     CONSTRAINT [DF_RELEASE_CONDITION_CreatedDate] DEFAULT (getdate()) NULL
);

