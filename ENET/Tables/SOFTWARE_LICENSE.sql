﻿CREATE TABLE [dbo].[SOFTWARE_LICENSE] (
    [SoftwareLicenseId]    INT            IDENTITY (1, 1) NOT NULL,
    [SoftwareId]           INT            NULL,
    [SoftwareLicenseDesc]  VARCHAR (1000) NULL,
    [SoftwareVersion]      VARCHAR (30)   NULL,
    [Upgrade]              BIT            CONSTRAINT [DF_SOFTWARE_LICENSE_Upgrade] DEFAULT ((0)) NULL,
    [PurchaseDate]         DATETIME       NULL,
    [Cost]                 MONEY          CONSTRAINT [DF_SOFTWARE_LICENSE_Cost] DEFAULT ((0)) NULL,
    [NumberofDisks]        INT            CONSTRAINT [DF_SOFTWARE_LICENSE_NumberofDisks] DEFAULT ((0)) NULL,
    [SoftwareRegistration] VARCHAR (50)   NULL,
    [CDKey]                VARCHAR (50)   NULL,
    [SoftwareLocationId]   INT            NULL,
    [OtherLocation]        VARCHAR (50)   NULL,
    [CreatedDate]          DATETIME       CONSTRAINT [DF_SOFTWARE_LICENSE_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]            INT            CONSTRAINT [DF_SOFTWARE_LICENSE_CreatedBy] DEFAULT ((0)) NULL,
    [UpdatedDate]          DATETIME       CONSTRAINT [DF_SOFTWARE_LICENSE_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]            INT            CONSTRAINT [DF_SOFTWARE_LICENSE_UpdatedBy] DEFAULT ((0)) NULL,
    [Inactive]             BIT            CONSTRAINT [DF_SOFTWARE_LICENSE_Inactive] DEFAULT ((0)) NULL,
    [SoftwareVendorId]     INT            NULL,
    [RequisitionNumber]    VARCHAR (50)   NULL,
    [PurchaseOrder]        VARCHAR (50)   NULL,
    [NumberofUsers]        INT            CONSTRAINT [DF_SOFTWARE_LICENSE_NumberofUsers] DEFAULT ((0)) NULL,
    [ExpirationDate]       DATETIME       CONSTRAINT [DF_SOFTWARE_LICENSE_ExpirationDate] DEFAULT ('1/1/1900') NULL,
    CONSTRAINT [PK_SOFTWARE_LICENSE] PRIMARY KEY CLUSTERED ([SoftwareLicenseId] ASC),
    CONSTRAINT [FK_SOFTWARE_LICENSE_SOFTWARE_LOCATION] FOREIGN KEY ([SoftwareLocationId]) REFERENCES [dbo].[SOFTWARE_LOCATION] ([SoftwareLocationId]),
    CONSTRAINT [FK_SOFTWARE_LICENSE_SOFTWARE_NAME] FOREIGN KEY ([SoftwareId]) REFERENCES [dbo].[SOFTWARE_NAME] ([SoftwareId]),
    CONSTRAINT [FK_SOFTWARE_LICENSE_SOFTWARE_VENDOR] FOREIGN KEY ([SoftwareVendorId]) REFERENCES [dbo].[SOFTWARE_VENDOR] ([SoftwareVendorId])
);

