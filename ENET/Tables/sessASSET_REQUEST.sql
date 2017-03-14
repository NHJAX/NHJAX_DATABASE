CREATE TABLE [dbo].[sessASSET_REQUEST] (
    [RequestId]         INT            IDENTITY (1, 1) NOT NULL,
    [CreatedFor]        INT            NULL,
    [AssetTypeId]       INT            NULL,
    [AssetSubTypeId]    INT            NULL,
    [ItemQuantity]      INT            NULL,
    [BaseId]            INT            NULL,
    [BuildingId]        INT            NULL,
    [DeckId]            INT            NULL,
    [ItemLocation]      VARCHAR (50)   NULL,
    [ItemJustification] VARCHAR (1000) NULL,
    [CreatedForAlpha]   VARCHAR (100)  NULL,
    [AssetTypeDesc]     VARCHAR (50)   NULL,
    [AssetSubTypeDesc]  VARCHAR (50)   NULL,
    [BaseDesc]          VARCHAR (50)   NULL,
    [BuildingDesc]      VARCHAR (50)   NULL,
    [DeckDesc]          VARCHAR (50)   NULL,
    [CreatedDate]       DATETIME       NULL,
    [CreatedBy]         INT            NULL,
    [UpdatedDate]       DATETIME       NULL,
    [UpdatedBy]         INT            NULL,
    CONSTRAINT [PK_sessASSET_REQUEST] PRIMARY KEY CLUSTERED ([RequestId] ASC)
);

