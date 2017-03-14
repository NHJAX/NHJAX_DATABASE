CREATE TABLE [dbo].[PREFERENCE] (
    [PreferenceId]   INT          NOT NULL,
    [PreferenceDesc] VARCHAR (50) NULL,
    [CreatedDate]    DATETIME     CONSTRAINT [DF_PREFERENCE_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_PREFERENCE] PRIMARY KEY CLUSTERED ([PreferenceId] ASC)
);

