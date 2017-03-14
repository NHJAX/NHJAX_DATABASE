CREATE TABLE [dbo].[ASSET_ORDER_STATUS] (
    [AssetOrderStatusId]   INT          NOT NULL,
    [AssetOrderStatusDesc] VARCHAR (50) NULL,
    [CreatedDate]          DATETIME     CONSTRAINT [DF_ASSET_ORDER_STATUS_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]            INT          CONSTRAINT [DF_ASSET_ORDER_STATUS_CreatedBy] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_ASSET_ORDER_STATUS] PRIMARY KEY CLUSTERED ([AssetOrderStatusId] ASC)
);

