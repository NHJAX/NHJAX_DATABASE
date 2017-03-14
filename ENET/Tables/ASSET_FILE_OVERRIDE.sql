CREATE TABLE [dbo].[ASSET_FILE_OVERRIDE] (
    [AssetFileOverrideId]  BIGINT   IDENTITY (1, 1) NOT NULL,
    [AssetId]              INT      NOT NULL,
    [AssetFileExtensionId] INT      NOT NULL,
    [AuditOverride]        BIT      CONSTRAINT [DF_ASSET_FILE_OVERRIDE_AuditOverride] DEFAULT ((0)) NOT NULL,
    [CreatedDate]          DATETIME CONSTRAINT [DF_ASSET_FILE_OVERRIDE_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]            INT      CONSTRAINT [DF_ASSET_FILE_OVERRIDE_CreatedBy] DEFAULT ((0)) NOT NULL,
    [UpdatedDate]          DATETIME CONSTRAINT [DF_ASSET_FILE_OVERRIDE_UpdateDate] DEFAULT (getdate()) NOT NULL,
    [UpdatedBy]            INT      CONSTRAINT [DF_ASSET_FILE_OVERRIDE_UpdatedBy] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_ASSET_FILE_OVERRIDE] PRIMARY KEY CLUSTERED ([AssetFileOverrideId] ASC),
    CONSTRAINT [FK_ASSET_FILE_OVERRIDE_ASSET] FOREIGN KEY ([AssetId]) REFERENCES [dbo].[ASSET] ([AssetId]),
    CONSTRAINT [FK_ASSET_FILE_OVERRIDE_ASSET_FILE_EXTENSION] FOREIGN KEY ([AssetFileExtensionId]) REFERENCES [dbo].[ASSET_FILE_EXTENSION] ([AssetFileExtensionId])
);

