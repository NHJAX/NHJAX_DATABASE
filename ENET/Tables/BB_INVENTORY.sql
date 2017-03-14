CREATE TABLE [dbo].[BB_INVENTORY] (
    [Room]           NVARCHAR (255) NULL,
    [Model]          NVARCHAR (255) NULL,
    [Serial Number]  NVARCHAR (255) NULL,
    [Equip Bar Code] NVARCHAR (255) NULL,
    [Plant Number]   NVARCHAR (255) NULL,
    [Network Name]   NVARCHAR (255) NULL,
    [F7]             NVARCHAR (255) NULL,
    [Asset Type]     NVARCHAR (255) NULL,
    [Manufacturer]   NVARCHAR (255) NULL,
    [NOTES]          NVARCHAR (255) NULL,
    [Project]        NVARCHAR (255) NULL,
    [DispositionId]  INT            CONSTRAINT [DF_BB_INVENTORY_DispositionId] DEFAULT ((1)) NULL,
    [SourceTable]    NVARCHAR (255) NULL,
    [CreatedDate]    DATETIME       CONSTRAINT [DF_BB_INVENTORY_CreatedDate] DEFAULT (getdate()) NULL
);

