CREATE TABLE [dbo].[ASSET_TYPE] (
    [AssetTypeId]   INT          IDENTITY (0, 1) NOT NULL,
    [AssetTypeDesc] VARCHAR (50) NULL,
    [CreatedBy]     INT          CONSTRAINT [DF_ASSET_TYPE_CreatedBy] DEFAULT ((0)) NULL,
    [CreatedDate]   DATETIME     CONSTRAINT [DF_ASSET_TYPE_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]   DATETIME     CONSTRAINT [DF_ASSET_TYPE_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]     INT          CONSTRAINT [DF_ASSET_TYPE_UpdatedBy] DEFAULT ((0)) NULL,
    [Inactive]      BIT          CONSTRAINT [DF_ASSET_TYPE_Inactive] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_ASSET_TYPE] PRIMARY KEY CLUSTERED ([AssetTypeId] ASC)
);

