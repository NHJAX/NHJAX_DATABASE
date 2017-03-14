CREATE TABLE [dbo].[ASSET_SUBTYPE] (
    [AssetSubTypeId]   INT          IDENTITY (0, 1) NOT NULL,
    [AssetSubTypeDesc] VARCHAR (50) NULL,
    [AssetTypeId]      INT          NULL,
    [CreatedDate]      DATETIME     CONSTRAINT [DF_ASSET_SUBTYPE_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]        INT          CONSTRAINT [DF_ASSET_SUBTYPE_CreatedBy] DEFAULT ((0)) NULL,
    [UpdatedDate]      DATETIME     CONSTRAINT [DF_ASSET_SUBTYPE_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]        INT          CONSTRAINT [DF_ASSET_SUBTYPE_UpdatedBy] DEFAULT ((0)) NULL,
    [Inactive]         BIT          CONSTRAINT [DF_ASSET_SUBTYPE_Inactive] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_ASSET_SUBTYPE] PRIMARY KEY CLUSTERED ([AssetSubTypeId] ASC)
);

