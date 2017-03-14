CREATE TABLE [dbo].[PATIENT_SUMMARY] (
    [PatientSummaryId] BIGINT   IDENTITY (1, 1) NOT NULL,
    [PatientId]        BIGINT   NOT NULL,
    [PatientStatId]    BIGINT   NOT NULL,
    [SourceSystemId]   BIGINT   NOT NULL,
    [StatValue]        INT      NULL,
    [MinDate]          DATETIME NULL,
    [MaxDate]          DATETIME NULL,
    [CreatedDate]      DATETIME CONSTRAINT [DF_PATIENT_SUMMARY_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]      DATETIME CONSTRAINT [DF_PATIENT_SUMMARY_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_PATIENT_SUMMARY] PRIMARY KEY CLUSTERED ([PatientSummaryId] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_PATIENT_SUMMARY_PatientId_PatientStatId_SourceSystemId]
    ON [dbo].[PATIENT_SUMMARY]([PatientId] ASC, [PatientStatId] ASC, [SourceSystemId] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);

