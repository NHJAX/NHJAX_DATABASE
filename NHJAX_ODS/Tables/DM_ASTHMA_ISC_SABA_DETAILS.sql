CREATE TABLE [dbo].[DM_ASTHMA_ISC_SABA_DETAILS] (
    [ICSSABARatioId]   BIGINT         IDENTITY (1, 1) NOT NULL,
    [PatientId]        BIGINT         NULL,
    [FullName]         NVARCHAR (100) NULL,
    [FMP]              INT            NULL,
    [SponsorSSN]       NVARCHAR (15)  NULL,
    [DOB]              DATETIME       NULL,
    [Age]              NVARCHAR (3)   NULL,
    [PCMId]            BIGINT         NULL,
    [PCMName]          NVARCHAR (100) NULL,
    [Hospitalizations] INT            NULL,
    [OutpatientVisits] INT            NULL,
    [ERVisits]         INT            NULL,
    [DispensingEvents] INT            NULL,
    [ICSId]            BIGINT         NULL,
    [ControlICSDesc]   NVARCHAR (75)  NULL,
    [ICSLastFill]      DATETIME       NULL,
    [SABAId]           BIGINT         NULL,
    [SABADesc]         NVARCHAR (75)  NULL,
    [SABALastFill]     DATETIME       NULL,
    [ICSCount]         INT            NULL,
    [SABACount]        INT            NULL,
    [CreatedDate]      DATETIME       CONSTRAINT [DF_DM_ASTHMA_ISC_SABA_DETAILS_CreatedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_DM_ASTHMA_ISC_SABA_DETAILS] PRIMARY KEY CLUSTERED ([ICSSABARatioId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_DM_ASTHMA_ICS_SABA_DETAILS_PATID_PCMID]
    ON [dbo].[DM_ASTHMA_ISC_SABA_DETAILS]([PatientId] ASC, [PCMId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DM_ASTHMA_ISC_SABA_DETAILS]
    ON [dbo].[DM_ASTHMA_ISC_SABA_DETAILS]([PatientId] ASC);

