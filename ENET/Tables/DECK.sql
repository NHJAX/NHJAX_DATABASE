CREATE TABLE [dbo].[DECK] (
    [DeckId]      INT          NOT NULL,
    [DeckDesc]    VARCHAR (50) NULL,
    [CreatedDate] DATETIME     CONSTRAINT [DF_DECK_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]   INT          CONSTRAINT [DF_DECK_CreatedBy] DEFAULT ((0)) NULL,
    [UpdatedDate] DATETIME     CONSTRAINT [DF_DECK_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]   INT          CONSTRAINT [DF_DECK_UpdatedBy] DEFAULT ((0)) NULL,
    [Inactive]    BIT          CONSTRAINT [DF_DECK_Inactive] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_DECK] PRIMARY KEY CLUSTERED ([DeckId] ASC)
);

