CREATE TABLE [dbo].[SOURCE_SYSTEM] (
    [SourceSystemId]   BIGINT       NOT NULL,
    [SourceSystemDesc] VARCHAR (50) NULL,
    [DisplayName]      VARCHAR (50) NULL,
    [CreatedDate]      DATETIME     CONSTRAINT [DF_SOURCE_SYSTEM_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_SOURCE_SYSTEM] PRIMARY KEY CLUSTERED ([SourceSystemId] ASC)
);

