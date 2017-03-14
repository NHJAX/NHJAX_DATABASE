CREATE TABLE [dbo].[DM_PHARMACY_CONTROLLED_SUBSTANCES_RXS] (
    [PrescriptionId]     BIGINT         NOT NULL,
    [RXNumber]           VARCHAR (20)   NULL,
    [DrugId]             BIGINT         NULL,
    [DrugDesc]           VARCHAR (41)   NULL,
    [SourceSystemId]     INT            NULL,
    [DrugScheduleCode]   VARCHAR (1)    NULL,
    [PatientId]          BIGINT         NULL,
    [PatientName]        VARCHAR (100)  NULL,
    [SSN]                VARCHAR (30)   NULL,
    [DisplayAge]         VARCHAR (5)    NULL,
    [BenefitsCategoryId] BIGINT         NULL,
    [ProviderId]         BIGINT         NULL,
    [LastFillDate]       DATETIME       NULL,
    [RefillsRemaining]   NUMERIC (8, 3) NULL,
    [Refills]            NUMERIC (8, 3) NULL,
    [DaysSupply]         INT            NULL,
    [Quantity]           INT            NULL,
    [Comments]           VARCHAR (80)   NULL,
    [Sig]                VARCHAR (220)  NULL,
    [Sig1]               VARCHAR (28)   NULL,
    [Sig2]               VARCHAR (28)   NULL,
    [Sig3]               VARCHAR (29)   NULL,
    [PharmacyId]         BIGINT         NULL,
    [PharmacyDesc]       VARCHAR (50)   NULL,
    PRIMARY KEY CLUSTERED ([PrescriptionId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_DM_CONTROLLED_SUBSTANCES_DrugId_PatientId]
    ON [dbo].[DM_PHARMACY_CONTROLLED_SUBSTANCES_RXS]([DrugId] ASC, [PatientId] ASC, [PrescriptionId] ASC);

