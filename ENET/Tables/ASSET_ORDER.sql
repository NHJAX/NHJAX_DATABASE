CREATE TABLE [dbo].[ASSET_ORDER] (
    [AssetOrderId]       INT            IDENTITY (1, 1) NOT NULL,
    [CreatedBy]          INT            CONSTRAINT [DF_ASSET_ORDER_CreatedBy] DEFAULT ((0)) NULL,
    [CreatedDate]        DATETIME       CONSTRAINT [DF_ASSET_ORDER_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]          INT            CONSTRAINT [DF_ASSET_ORDER_UpdatedBy] DEFAULT ((0)) NULL,
    [UpdatedDate]        DATETIME       CONSTRAINT [DF_ASSET_ORDER_UpdatedDate] DEFAULT (getdate()) NULL,
    [CreatedFor]         INT            NULL,
    [OrderNumber]        VARCHAR (50)   NULL,
    [AssetOrderStatusId] INT            CONSTRAINT [DF_ASSET_ORDER_AssetOrderStatusId] DEFAULT ((1)) NULL,
    [RejectReason]       VARCHAR (1000) NULL,
    CONSTRAINT [PK_ASSET_ORDER] PRIMARY KEY CLUSTERED ([AssetOrderId] ASC)
);

