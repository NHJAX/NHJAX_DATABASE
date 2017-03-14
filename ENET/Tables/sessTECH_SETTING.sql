CREATE TABLE [dbo].[sessTECH_SETTING] (
    [TechSettingId] INT      NOT NULL,
    [CreatedBy]     INT      CONSTRAINT [DF_sessTECH_SETTINGS_CreatedBy] DEFAULT ((0)) NULL,
    [CreatedDate]   DATETIME CONSTRAINT [DF_sessTECH_SETTINGS_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]     INT      CONSTRAINT [DF_sessTECH_SETTINGS_UpdatedBy] DEFAULT ((0)) NULL,
    [UpdatedDate]   DATETIME CONSTRAINT [DF_sessTECH_SETTINGS_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_sessTECH_SETTINGS] PRIMARY KEY CLUSTERED ([TechSettingId] ASC)
);

