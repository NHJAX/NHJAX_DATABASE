CREATE TABLE [dbo].[ASSET_PRINTER] (
    [AssetPrinterId] INT      IDENTITY (1, 1) NOT NULL,
    [AssetId]        INT      NULL,
    [PrinterId]      INT      NULL,
    [CreatedDate]    DATETIME CONSTRAINT [DF_ASSET_PRINTER_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]      INT      CONSTRAINT [DF_ASSET_PRINTER_CreatedBy] DEFAULT ((0)) NULL,
    [UpdatedDate]    DATETIME CONSTRAINT [DF_ASSET_PRINTER_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]      INT      CONSTRAINT [DF_ASSET_PRINTER_UpdatedBy] DEFAULT ((0)) NULL,
    [Inactive]       BIT      CONSTRAINT [DF_ASSET_PRINTER_Inactive] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_ASSET_PRINTER] PRIMARY KEY CLUSTERED ([AssetPrinterId] ASC),
    CONSTRAINT [FK_ASSET_PRINTER_ASSET] FOREIGN KEY ([AssetId]) REFERENCES [dbo].[ASSET] ([AssetId])
);

