CREATE TABLE [dbo].[ASSET_MAC] (
    [AssetMACId]  INT          IDENTITY (1, 1) NOT NULL,
    [AssetId]     INT          NULL,
    [MACAddress]  VARCHAR (50) NULL,
    [CreatedDate] DATETIME     CONSTRAINT [DF_ASSET_MAC_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]   INT          CONSTRAINT [DF_ASSET_MAC_CreatedBy] DEFAULT ((0)) NULL,
    [UpdatedDate] DATETIME     CONSTRAINT [DF_ASSET_MAC_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]   INT          CONSTRAINT [DF_ASSET_MAC_UpdatedBy] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_ASSET_MAC] PRIMARY KEY CLUSTERED ([AssetMACId] ASC),
    CONSTRAINT [FK_ASSET_MAC_ASSET] FOREIGN KEY ([AssetId]) REFERENCES [dbo].[ASSET] ([AssetId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_ASSET_MAC_MACAddress]
    ON [dbo].[ASSET_MAC]([MACAddress] ASC);

