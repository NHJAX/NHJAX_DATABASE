CREATE TABLE [dbo].[ENCOUNTER_DIAGNOSIS] (
    [EncounterDiagnosisId] BIGINT        IDENTITY (1, 1) NOT NULL,
    [PatientEncounterId]   BIGINT        NULL,
    [DiagnosisId]          BIGINT        NULL,
    [Priority]             INT           NULL,
    [Description]          VARCHAR (500) NULL,
    [CreatedDate]          DATETIME      CONSTRAINT [DF_ENCOUNTER_DIAGNOSIS_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]          DATETIME      CONSTRAINT [DF_ENCOUNTER_DIAGNOSIS_UpdatedDate] DEFAULT (getdate()) NULL,
    [SourceSystemId]       BIGINT        CONSTRAINT [DF_ENCOUNTER_DIAGNOSIS_SourceSystemId] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_ENCOUNTER_DIAGNOSIS] PRIMARY KEY CLUSTERED ([EncounterDiagnosisId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ENCOUNTER_DIAGNOSIS_ID]
    ON [dbo].[ENCOUNTER_DIAGNOSIS]([PatientEncounterId] ASC, [DiagnosisId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ENCOUNTER_DIAGNOSIS_EncounterdiagnosisId,DiagnosisCode]
    ON [dbo].[ENCOUNTER_DIAGNOSIS]([EncounterDiagnosisId] ASC, [PatientEncounterId] ASC, [DiagnosisId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ENCOUNTER_DIAGNOSIS_PatientEncounterId]
    ON [dbo].[ENCOUNTER_DIAGNOSIS]([PatientEncounterId] ASC);

