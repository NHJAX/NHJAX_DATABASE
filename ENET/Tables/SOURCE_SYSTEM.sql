CREATE TABLE [dbo].[SOURCE_SYSTEM] (
    [SourceSystemId]   INT          NULL,
    [SourceSystemDesc] VARCHAR (50) NULL,
    [CreatedDate]      DATETIME     CONSTRAINT [DF_SOURCE_SYSTEM_CreatedDate] DEFAULT (getdate()) NULL
);

