CREATE TABLE [dbo].[IMPORT_LOG] (
    [ImportLogId]   BIGINT         IDENTITY (1, 1) NOT NULL,
    [ImportLogDesc] VARCHAR (1000) NULL,
    [CreatedDate]   DATETIME       CONSTRAINT [DF_IMPORT_LOG_CreatedDate] DEFAULT (getdate()) NULL,
    [UserId]        INT            CONSTRAINT [DF_IMPORT_LOG_UserId] DEFAULT ((0)) NULL,
    [LogTypeId]     INT            CONSTRAINT [DF_IMPORT_LOG_LogTypeId] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_IMPORT_LOG] PRIMARY KEY CLUSTERED ([ImportLogId] ASC)
);

