CREATE TABLE [dbo].[ASSET_ORDER_ITEM] (
    [AssetOrderItemId]  INT            IDENTITY (1, 1) NOT NULL,
    [AssetOrderId]      INT            NULL,
    [AssetTypeId]       INT            NULL,
    [BuildingId]        INT            NULL,
    [DeckId]            INT            NULL,
    [ItemLocation]      VARCHAR (50)   NULL,
    [ItemQuantity]      INT            NULL,
    [AssetSubTypeId]    INT            NULL,
    [ItemJustification] VARCHAR (1000) NULL,
    [CreatedBy]         INT            NULL,
    [CreatedDate]       DATETIME       CONSTRAINT [DF_ASSET_ORDER_ITEM_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]         INT            NULL,
    [UpdatedDate]       DATETIME       CONSTRAINT [DF_ASSET_ORDER_ITEM_UpdatedDate] DEFAULT (getdate()) NULL,
    [Rejected]          BIT            CONSTRAINT [DF_ASSET_ORDER_ITEM_Rejected] DEFAULT ((0)) NULL,
    [RejectedReason]    VARCHAR (1000) NULL,
    CONSTRAINT [PK_ASSET_ORDER_ITEM] PRIMARY KEY CLUSTERED ([AssetOrderItemId] ASC)
);

