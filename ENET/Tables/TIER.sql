CREATE TABLE [dbo].[TIER] (
    [TierId]              INT           NOT NULL,
    [TierDesc]            VARCHAR (50)  NULL,
    [TierLongDescription] VARCHAR (100) NULL,
    [CreatedDate]         DATETIME      CONSTRAINT [DF_TIER_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_TIER] PRIMARY KEY CLUSTERED ([TierId] ASC)
);

