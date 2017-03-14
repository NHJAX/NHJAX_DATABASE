CREATE TABLE [dbo].[LANGUAGE_SPOKEN] (
    [LanguageSpokenId] BIGINT   IDENTITY (1, 1) NOT NULL,
    [UserId]           INT      NULL,
    [LanguageId]       INT      NULL,
    [CreatedDate]      DATETIME CONSTRAINT [DF_LANGUAGE_SPOKEN_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_LANGUAGE_SPOKEN] PRIMARY KEY CLUSTERED ([LanguageSpokenId] ASC)
);

