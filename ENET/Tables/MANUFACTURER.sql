CREATE TABLE [dbo].[MANUFACTURER] (
    [ManufacturerId]   INT          IDENTITY (1, 1) NOT NULL,
    [ManufacturerDesc] VARCHAR (50) NULL,
    [CreatedDate]      DATETIME     CONSTRAINT [DF_MANUFACTURER_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]        INT          CONSTRAINT [DF_MANUFACTURER_CreatedBy] DEFAULT ((0)) NULL,
    [UpdatedDate]      DATETIME     CONSTRAINT [DF_MANUFACTURER_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]        INT          CONSTRAINT [DF_MANUFACTURER_UpdatedBy] DEFAULT ((0)) NULL,
    [Inactive]         BIT          CONSTRAINT [DF_MANUFACTURER_Inactive] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_MANUFACTURER] PRIMARY KEY CLUSTERED ([ManufacturerId] ASC)
);

