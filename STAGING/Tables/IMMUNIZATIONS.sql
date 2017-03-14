CREATE TABLE [dbo].[IMMUNIZATIONS] (
    [FullName]                       NVARCHAR (255) NULL,
    [DOB]                            DATETIME       NULL,
    [FMP]                            NVARCHAR (255) NULL,
    [FMPSponsorSSN]                  NVARCHAR (255) NULL,
    [SponsorSSN]                     NVARCHAR (255) NULL,
    [ImmunizationVaccineName]        NVARCHAR (255) NULL,
    [ImmunizationDate]               DATETIME       NULL,
    [ImmunizationDateNextDue]        DATETIME       NULL,
    [ImmunizationSeries]             FLOAT (53)     NULL,
    [ImmunizationExemption]          NVARCHAR (255) NULL,
    [ImmunizationExemptionExpirDate] DATETIME       NULL,
    [ImmunizationDosage]             NVARCHAR (255) NULL,
    [ImmunizationLotNumber]          NVARCHAR (255) NULL,
    [ImmunizationManufacturer]       NVARCHAR (255) NULL,
    [ImmunizationCode]               NVARCHAR (255) NULL,
    [ImmunizationTypeId]             INT            NULL,
    [CreatedDate]                    DATETIME       CONSTRAINT [DF_IMMUNIZATIONS_CreatedDate] DEFAULT (getdate()) NULL,
    [CDMAppointmentId]               BIGINT         CONSTRAINT [DF_IMMUNIZATIONS_CDMAppointmentId] DEFAULT ((999999999)) NULL
);

