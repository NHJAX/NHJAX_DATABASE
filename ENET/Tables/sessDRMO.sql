CREATE TABLE [dbo].[sessDRMO] (
    [DRMOId]          INT           IDENTITY (1, 1) NOT NULL,
    [PlantPrefix]     VARCHAR (50)  NULL,
    [PlantNumber]     VARCHAR (50)  NULL,
    [SerialNumber]    VARCHAR (50)  NULL,
    [EquipmentNumber] VARCHAR (50)  NULL,
    [CreatedDate]     DATETIME      CONSTRAINT [DF_sessDRMO_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]       INT           NULL,
    [UpdatedDate]     DATETIME      CONSTRAINT [DF_sessDRMO_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]       INT           NULL,
    [AssetId]         INT           NULL,
    [StatusFlag]      INT           CONSTRAINT [DF_sessDRMO_StatusFlag] DEFAULT ((0)) NULL,
    [NetworkName]     VARCHAR (100) NULL,
    CONSTRAINT [PK_sessDRMO] PRIMARY KEY CLUSTERED ([DRMOId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_sessDRMO_CreatedBy]
    ON [dbo].[sessDRMO]([CreatedBy] ASC);

