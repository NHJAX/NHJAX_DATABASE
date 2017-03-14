CREATE TABLE [dbo].[PREFERENCE] (
    [PreferenceId]    INT            NOT NULL,
    [PreferenceDesc]  VARCHAR (50)   NULL,
    [PreferenceValue] VARCHAR (1000) NULL,
    [CreatedDate]     DATETIME       CONSTRAINT [DF_PREFERENCE_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]     DATETIME       CONSTRAINT [DF_PREFERENCE_UpdatedDate] DEFAULT (getdate()) NULL,
    [Inactive]        BIT            CONSTRAINT [DF_PREFERENCE_Inactive] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_PREFERENCE] PRIMARY KEY CLUSTERED ([PreferenceId] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Custom Preference/Parameters Settings', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PREFERENCE', @level2type = N'COLUMN', @level2name = N'PreferenceId';

