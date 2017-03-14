CREATE TABLE [dbo].[TICKET_ASSET] (
    [TicketAssetId] BIGINT   IDENTITY (1, 1) NOT NULL,
    [TicketId]      INT      NULL,
    [AssetId]       INT      NULL,
    [CreatedDate]   DATETIME CONSTRAINT [DF_TICKET_ASSET_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_TICKET_ASSET] PRIMARY KEY CLUSTERED ([TicketAssetId] ASC)
);

