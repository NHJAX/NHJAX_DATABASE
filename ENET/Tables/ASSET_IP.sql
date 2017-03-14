CREATE TABLE [dbo].[ASSET_IP] (
    [AssetIPId]   INT          IDENTITY (1, 1) NOT NULL,
    [AssetId]     INT          NULL,
    [IPAddress]   VARCHAR (50) NULL,
    [CreatedDate] DATETIME     CONSTRAINT [DF_ASSET_IP_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]   INT          CONSTRAINT [DF_ASSET_IP_CreatedBy] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_ASSET_IP] PRIMARY KEY CLUSTERED ([AssetIPId] ASC),
    CONSTRAINT [FK_ASSET_IP_ASSET] FOREIGN KEY ([AssetId]) REFERENCES [dbo].[ASSET] ([AssetId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_ASSET_IP_AssetId_IPAddress]
    ON [dbo].[ASSET_IP]([AssetId] ASC, [IPAddress] ASC);

