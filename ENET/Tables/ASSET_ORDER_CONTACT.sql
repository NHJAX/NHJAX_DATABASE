CREATE TABLE [dbo].[ASSET_ORDER_CONTACT] (
    [AssetOrderContactId] INT      IDENTITY (1, 1) NOT NULL,
    [DepartmentId]        INT      NULL,
    [TechnicianId]        INT      NULL,
    [PrimaryContact]      BIT      CONSTRAINT [DF_ASSET_ORDER_CONTACT_PrimaryContact] DEFAULT ((0)) NULL,
    [CreatedDate]         DATETIME CONSTRAINT [DF_ASSET_ORDER_CONTACT_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]           INT      CONSTRAINT [DF_ASSET_ORDER_CONTACT_CreatedBy] DEFAULT ((0)) NULL,
    [UpdatedDate]         DATETIME CONSTRAINT [DF_ASSET_ORDER_CONTACT_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]           INT      CONSTRAINT [DF_ASSET_ORDER_CONTACT_UpdatedBy] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_ASSET_ORDER_CONTACT] PRIMARY KEY CLUSTERED ([AssetOrderContactId] ASC)
);

