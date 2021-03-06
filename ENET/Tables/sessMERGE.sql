﻿CREATE TABLE [dbo].[sessMERGE] (
    [SessionKey]         VARCHAR (100)   NOT NULL,
    [ModelId]            INT             CONSTRAINT [DF_sessMERGE_ModelId] DEFAULT ((1)) NULL,
    [ManufacturerId]     INT             CONSTRAINT [DF_sessMERGE_ManufacturerId] DEFAULT ((324)) NULL,
    [PlantAccountPrefix] VARCHAR (50)    NULL,
    [PlantAccountNumber] VARCHAR (50)    NULL,
    [NetworkName]        VARCHAR (50)    NULL,
    [SerialNumber]       VARCHAR (50)    NULL,
    [AcquisitionDate]    DATETIME        CONSTRAINT [DF_sessMERGE_AcquisitionDate] DEFAULT ('1/1/1900') NULL,
    [MacAddress]         VARCHAR (50)    NULL,
    [Remarks]            VARCHAR (1000)  NULL,
    [AssetDesc]          VARCHAR (100)   NULL,
    [WarrantyMonths]     INT             CONSTRAINT [DF_sessMERGE_WarrantyMonths] DEFAULT ((0)) NULL,
    [UnitCost]           MONEY           CONSTRAINT [DF_sessMERGE_UnitCost] DEFAULT ((0)) NULL,
    [EqpMgtBarCode]      VARCHAR (15)    NULL,
    [ReqDocNumber]       VARCHAR (20)    NULL,
    [ProjectId]          INT             CONSTRAINT [DF_sessMERGE_ProjectId] DEFAULT ((13)) NULL,
    [AssetTypeId]        INT             CONSTRAINT [DF_sessMERGE_AssetTypeId] DEFAULT ((0)) NULL,
    [AssetSubtypeId]     INT             CONSTRAINT [DF_sessMERGE_AssetSubtypeId] DEFAULT ((0)) NULL,
    [DepartmentId]       INT             CONSTRAINT [DF_sessMERGE_DepartmentId] DEFAULT ((168)) NULL,
    [BaseId]             INT             CONSTRAINT [DF_sessMERGE_BaseId] DEFAULT ((10)) NULL,
    [BuildingId]         INT             CONSTRAINT [DF_sessMERGE_BuildingId] DEFAULT ((5)) NULL,
    [DeckId]             INT             CONSTRAINT [DF_sessMERGE_DeckId] DEFAULT ((9)) NULL,
    [Room]               VARCHAR (50)    NULL,
    [MissionCritical]    BIT             CONSTRAINT [DF_sessMERGE_MissionCritical] DEFAULT ((1)) NULL,
    [RemoteAccess]       BIT             CONSTRAINT [DF_sessMERGE_RemoteAccess] DEFAULT ((0)) NULL,
    [OnLoan]             BIT             CONSTRAINT [DF_sessMERGE_OnLoan] DEFAULT ((0)) NULL,
    [LeasedPurchased]    INT             CONSTRAINT [DF_sessMERGE_LeasedPurchased] DEFAULT ((0)) NULL,
    [DispositionId]      INT             CONSTRAINT [DF_sessMERGE_DispositionId] DEFAULT ((0)) NULL,
    [DomainId]           INT             NULL,
    [POCId]              INT             NULL,
    [IPAddress]          VARCHAR (50)    NULL,
    [HardDriveSize]      DECIMAL (19, 4) CONSTRAINT [DF_sessMERGE_HardDriveSize] DEFAULT ((0)) NULL,
    [RAM]                DECIMAL (19, 4) CONSTRAINT [DF_sessMERGE_RAM] DEFAULT ((0)) NULL,
    [CPUSpeed]           DECIMAL (19, 4) CONSTRAINT [DF_sessMERGE_CPUSpeed] DEFAULT ((0)) NULL,
    [CreatedBy]          INT             NULL,
    [CreatedDate]        DATETIME        CONSTRAINT [DF_sessMERGE_CreatedDate] DEFAULT (getdate()) NULL,
    [InventoryDate]      DATETIME        NULL,
    [PrinterConfig]      INT             CONSTRAINT [DF_sessMERGE_PrinterConfig] DEFAULT ((0)) NULL,
    [SharePC]            INT             NULL,
    [AudienceId]         BIGINT          NULL,
    CONSTRAINT [PK_sessMERGE] PRIMARY KEY CLUSTERED ([SessionKey] ASC)
);

