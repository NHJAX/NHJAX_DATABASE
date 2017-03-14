CREATE TABLE [dbo].[xxx20141024InventoryRADC] (
    [F1]        NVARCHAR (255) NULL,
    [Completed] BIT            CONSTRAINT [DF_xxx20141024InventoryRADC_Completed] DEFAULT ((0)) NULL
);

