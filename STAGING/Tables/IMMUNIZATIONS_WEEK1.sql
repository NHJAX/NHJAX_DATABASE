CREATE TABLE [dbo].[IMMUNIZATIONS_WEEK1] (
    [Full Name]                          NVARCHAR (255) NULL,
    [DOB]                                DATETIME       NULL,
    [FMP]                                NVARCHAR (255) NULL,
    [FMP Sponsor SSN]                    NVARCHAR (255) NULL,
    [Sponsor SSN]                        NVARCHAR (255) NULL,
    [Immunization Vaccine Name]          NVARCHAR (255) NULL,
    [Immunization Date]                  DATETIME       NULL,
    [Immunization Date Next Due]         DATETIME       NULL,
    [Immunization Series]                FLOAT (53)     NULL,
    [Immunization Exemption]             NVARCHAR (255) NULL,
    [Immunization Exemption Expir# Date] DATETIME       NULL,
    [Immunization Dosage]                NVARCHAR (255) NULL,
    [Immunization Lot Number of Vaccine] NVARCHAR (255) NULL,
    [Immunization Manufacturer]          NVARCHAR (255) NULL,
    [Immunization ICD]                   NVARCHAR (255) NULL,
    [Immunization CPT]                   NVARCHAR (255) NULL
);

