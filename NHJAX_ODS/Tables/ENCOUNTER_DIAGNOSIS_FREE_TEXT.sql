CREATE TABLE [dbo].[ENCOUNTER_DIAGNOSIS_FREE_TEXT] (
    [EncounterDiagnosisFreeTextId]  BIGINT         IDENTITY (1, 1) NOT NULL,
    [PatientEncounterId]            BIGINT         NULL,
    [EncounterDiagnosisFreeTextKey] NUMERIC (7, 3) NULL,
    [DiagnosisFreeText]             VARCHAR (61)   NULL,
    [CreatedDate]                   DATETIME       CONSTRAINT [DF_ENCOUNTER_DIAGNOSIS_FREE_TEXT_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_ENCOUNTER_DIAGNOSIS_FREE_TEXT] PRIMARY KEY CLUSTERED ([EncounterDiagnosisFreeTextId] ASC),
    CONSTRAINT [FK_ENCOUNTER_DIAGNOSIS_FREE_TEXT_PATIENT_ENCOUNTER] FOREIGN KEY ([PatientEncounterId]) REFERENCES [dbo].[PATIENT_ENCOUNTER] ([PatientEncounterId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_ENCOUNTER_DIAGNOSIS_FREE_TEXT_PatientEncounterId_EncounterDiagnosisFreeTextKey]
    ON [dbo].[ENCOUNTER_DIAGNOSIS_FREE_TEXT]([PatientEncounterId] ASC, [EncounterDiagnosisFreeTextKey] ASC);

