CREATE TABLE [dbo].[FLAG] (
    [FlagId]      INT          NOT NULL,
    [FlagDesc]    VARCHAR (50) NULL,
    [CreatedDate] DATETIME     CONSTRAINT [DF_FLAG_CreatedDate] DEFAULT (getdate()) NULL
);

