CREATE TABLE [dbo].[LANGUAGE] (
    [LanguageId]   INT          IDENTITY (1, 1) NOT NULL,
    [LanguageDesc] VARCHAR (50) NULL,
    [CreatedDate]  DATETIME     CONSTRAINT [DF_LANGUAGE_CreatedDate] DEFAULT (getdate()) NULL,
    [Inactive]     BIT          CONSTRAINT [DF_LANGUAGE_Inactive] DEFAULT ((0)) NULL,
    [LanguageCode] NVARCHAR (2) NULL,
    CONSTRAINT [PK_LANGUAGE] PRIMARY KEY CLUSTERED ([LanguageId] ASC)
);

