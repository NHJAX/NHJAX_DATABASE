CREATE TABLE [dbo].[AHLTA_IMMUNIZATION] (
    [AhltaImmunizationId]             BIGINT        IDENTITY (1, 1) NOT NULL,
    [PatientEncounterId]              BIGINT        NOT NULL,
    [ImmunizationVaccineName]         VARCHAR (255) NULL,
    [ImmunizationDate]                DATETIME      NULL,
    [ImmunizationDateNextDue]         DATETIME      NULL,
    [ImmunizationSeries]              FLOAT (53)    NULL,
    [ImmunizationExemption]           VARCHAR (50)  NULL,
    [ImmunizationExemptionExpireDate] DATETIME      NULL,
    [ImmunizationDosage]              VARCHAR (50)  NULL,
    [ImmunizationLotNumber]           VARCHAR (50)  NULL,
    [ImmunizationCodeId]              BIGINT        NULL,
    [ImmunizationTypeId]              INT           NULL,
    [ImmunizationManufacturerId]      BIGINT        CONSTRAINT [DF_AHLTA_IMMUNIZATION_ImmunizationManufacturerId] DEFAULT ((19)) NULL,
    [CreatedDate]                     DATETIME      CONSTRAINT [DF_AHLTA_IMMUNIZATION_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_AHLTA_IMMUNIZATION_1] PRIMARY KEY CLUSTERED ([AhltaImmunizationId] ASC)
);

