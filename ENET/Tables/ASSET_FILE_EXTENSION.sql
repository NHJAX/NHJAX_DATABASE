CREATE TABLE [dbo].[ASSET_FILE_EXTENSION] (
    [AssetFileExtensionId]   INT          IDENTITY (1, 1) NOT NULL,
    [AssetFileExtensionDesc] VARCHAR (50) NULL,
    [CreatedBy]              INT          CONSTRAINT [DF_ASSET_FILE_EXTENSION_CreatedBy] DEFAULT ((0)) NULL,
    [CreatedDate]            DATETIME     CONSTRAINT [DF_ASSET_FILE_EXTENSION_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]              INT          CONSTRAINT [DF_ASSET_FILE_EXTENSION_UpdatedBy] DEFAULT ((0)) NULL,
    [UpdatedDate]            DATETIME     CONSTRAINT [DF_ASSET_FILE_EXTENSION_UpdatedDate] DEFAULT (getdate()) NULL,
    [Inactive]               BIT          CONSTRAINT [DF_ASSET_FILE_EXTENSION_Inactive] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_ASSET_FILE_EXTENSION] PRIMARY KEY CLUSTERED ([AssetFileExtensionId] ASC)
);

