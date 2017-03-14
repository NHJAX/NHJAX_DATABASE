CREATE TABLE [dbo].[SOFTWARE_VENDOR] (
    [SoftwareVendorId]   INT          IDENTITY (1, 1) NOT NULL,
    [SoftwareVendorDesc] VARCHAR (50) NULL,
    [CreatedDate]        DATETIME     CONSTRAINT [DF_SOFTWARE_VENDOR_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]          INT          CONSTRAINT [DF_SOFTWARE_VENDOR_CreatedBy] DEFAULT ((0)) NULL,
    [UpdatedDate]        DATETIME     CONSTRAINT [DF_SOFTWARE_VENDOR_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]          INT          CONSTRAINT [DF_SOFTWARE_VENDOR_UpdatedBy] DEFAULT ((0)) NULL,
    [Inactive]           BIT          CONSTRAINT [DF_SOFTWARE_VENDOR_Inactive] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_SOFTWARE_VENDOR] PRIMARY KEY CLUSTERED ([SoftwareVendorId] ASC)
);

