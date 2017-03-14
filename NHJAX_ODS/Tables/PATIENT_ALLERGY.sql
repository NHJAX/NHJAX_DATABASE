CREATE TABLE [dbo].[PATIENT_ALLERGY] (
    [PatientAllergyId]  BIGINT         IDENTITY (1, 1) NOT NULL,
    [PatientAllergyKey] NUMERIC (8, 3) NULL,
    [PatientId]         BIGINT         NULL,
    [AllergyId]         BIGINT         NULL,
    [Comments]          VARCHAR (200)  NULL,
    [CreatedDate]       DATETIME       CONSTRAINT [DF_PATIENT_ALLERGY_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]       DATETIME       CONSTRAINT [DF_PATIENT_ALLERGY_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_PATIENT_ALLERGY] PRIMARY KEY CLUSTERED ([PatientAllergyId] ASC),
    CONSTRAINT [FK_PATIENT_ALLERGY_ALLERGY] FOREIGN KEY ([AllergyId]) REFERENCES [dbo].[ALLERGY] ([AllergyId]),
    CONSTRAINT [FK_PATIENT_ALLERGY_PATIENT] FOREIGN KEY ([PatientId]) REFERENCES [dbo].[PATIENT] ([PatientId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_PATIENT_ALLERGY_PatientId_AllergyId_PatientAllergyKey]
    ON [dbo].[PATIENT_ALLERGY]([PatientAllergyKey] ASC, [PatientId] ASC, [AllergyId] ASC);

