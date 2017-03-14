CREATE TABLE [dbo].[ASSET_FILE_ALERT] (
    [AssetFileAlertId]   INT           IDENTITY (1, 1) NOT NULL,
    [AssetFileAlertDesc] VARCHAR (100) NULL,
    [CreatedDate]        DATETIME      CONSTRAINT [DF_ASSET_FILE_ALERT_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]          INT           CONSTRAINT [DF_ASSET_FILE_ALERT_CreatedBy] DEFAULT ((0)) NULL,
    [UpdatedDate]        DATETIME      CONSTRAINT [DF_ASSET_FILE_ALERT_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]          INT           CONSTRAINT [DF_ASSET_FILE_ALERT_UpdatedBy] DEFAULT ((0)) NULL,
    [Inactive]           BIT           CONSTRAINT [DF_ASSET_FILE_ALERT_Inactive] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_ASSET_FILE_ALERT] PRIMARY KEY CLUSTERED ([AssetFileAlertId] ASC)
);

