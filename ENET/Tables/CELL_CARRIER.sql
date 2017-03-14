CREATE TABLE [dbo].[CELL_CARRIER] (
    [CellCarrierId]   INT           NOT NULL,
    [CellCarrierDesc] NVARCHAR (50) NULL,
    [CreatedDate]     DATETIME      CONSTRAINT [DF_CELL_CARRIER_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_CELL_CARRIER] PRIMARY KEY CLUSTERED ([CellCarrierId] ASC)
);

