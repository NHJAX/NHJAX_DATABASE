CREATE TABLE [dbo].[PREFERENCE] (
    [PreferenceId]   INT          IDENTITY (1, 1) NOT NULL,
    [PreferenceDesc] VARCHAR (50) NULL,
    [CreatedBy]      INT          CONSTRAINT [DF_PREFERENCE_CreatedBy] DEFAULT ((0)) NULL,
    [CreatedDate]    DATETIME     CONSTRAINT [DF_PREFERENCE_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_PREFERENCE] PRIMARY KEY CLUSTERED ([PreferenceId] ASC)
);

