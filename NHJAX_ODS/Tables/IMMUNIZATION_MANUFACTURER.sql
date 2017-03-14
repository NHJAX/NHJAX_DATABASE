CREATE TABLE [dbo].[IMMUNIZATION_MANUFACTURER] (
    [ImmunizationManufacturerId]   BIGINT       IDENTITY (1, 1) NOT NULL,
    [ImmunizationManufacturerDesc] VARCHAR (50) NULL,
    [CreatedDate]                  DATETIME     CONSTRAINT [DF_IMMUNIZATION_MANUFACTURER_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_IMMUNIZATION_MANUFACTURER] PRIMARY KEY CLUSTERED ([ImmunizationManufacturerId] ASC)
);

