CREATE TABLE [dbo].[SOFTWARE_MANUFACTURER] (
    [SoftwareManufacturerId]   INT          IDENTITY (1, 1) NOT NULL,
    [SoftwareManufacturerDesc] VARCHAR (50) NULL,
    [CreatedDate]              DATETIME     CONSTRAINT [DF_SOFTWARE_MANUFACTURER_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]                INT          CONSTRAINT [DF_SOFTWARE_MANUFACTURER_CreatedBy] DEFAULT ((0)) NULL,
    [UpdatedDate]              DATETIME     CONSTRAINT [DF_SOFTWARE_MANUFACTURER_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]                INT          CONSTRAINT [DF_SOFTWARE_MANUFACTURER_UpdatedBy] DEFAULT ((0)) NULL,
    [Inactive]                 BIT          CONSTRAINT [DF_SOFTWARE_MANUFACTURER_Inactive] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_SOFTWARE_MANUFACTURER] PRIMARY KEY CLUSTERED ([SoftwareManufacturerId] ASC)
);

