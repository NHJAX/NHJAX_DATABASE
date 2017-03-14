CREATE TABLE [dbo].[sessINV_ASSET_TYPE] (
    [SessionKey]  INT      IDENTITY (1, 1) NOT NULL,
    [CreatedBy]   INT      NULL,
    [CreatedDate] DATETIME CONSTRAINT [DF_sessINV_ASSET_TYPE_CreatedDate] DEFAULT (getdate()) NULL,
    [AssetTypeId] INT      NULL,
    CONSTRAINT [PK_sessINV_ASSET_TYPE] PRIMARY KEY CLUSTERED ([SessionKey] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_sessINV_ASSET_TYPE_CreatedBy]
    ON [dbo].[sessINV_ASSET_TYPE]([CreatedBy] ASC);

