CREATE TABLE [dbo].[LANGUAGE_SPOKEN] (
    [LanguageSpokenId] BIGINT       IDENTITY (1, 1) NOT NULL,
    [PersonnelId]      BIGINT       NULL,
    [LanguageId]       INT          NULL,
    [CreatedDate]      DATETIME     CONSTRAINT [DF_LANGUAGE_SPOKEN_CreatedDate] DEFAULT (getdate()) NULL,
    [SessionKey]       VARCHAR (50) NULL,
    CONSTRAINT [PK_LANGUAGE_SPOKEN] PRIMARY KEY CLUSTERED ([LanguageSpokenId] ASC),
    CONSTRAINT [FK_LANGUAGE_SPOKEN_PERSONNEL] FOREIGN KEY ([PersonnelId]) REFERENCES [dbo].[PERSONNEL] ([PersonnelId]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IX_LANGUAGE_SPOKEN_SessionKey]
    ON [dbo].[LANGUAGE_SPOKEN]([SessionKey] ASC);

