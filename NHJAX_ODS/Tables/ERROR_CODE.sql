CREATE TABLE [dbo].[ERROR_CODE] (
    [ErrorCode]     INT          NOT NULL,
    [ErrorCodeDesc] VARCHAR (50) NULL,
    [CreatedDate]   DATETIME     CONSTRAINT [DF_ERROR_CODE_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_ERROR_CODE] PRIMARY KEY CLUSTERED ([ErrorCode] ASC)
);

