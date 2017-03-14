CREATE TABLE [dbo].[PATIENT_ENCOUNTER_SURGERY] (
    [PatientEncounterSurgeryId] BIGINT       IDENTITY (1, 1) NOT NULL,
    [PatientEncounterId]        BIGINT       NULL,
    [ReferenceNumber]           INT          NULL,
    [SurgeryDate]               DATETIME     NULL,
    [PreOpWard]                 VARCHAR (10) NULL,
    [PostOpWard]                VARCHAR (10) NULL,
    [CreatedDate]               DATETIME     CONSTRAINT [DF_PATIENT_ENCOUNTER_S3_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]                 INT          CONSTRAINT [DF_PATIENT_ENCOUNTER_S3_CreatedBy] DEFAULT ((0)) NULL,
    [UpdatedDate]               DATETIME     CONSTRAINT [DF_PATIENT_ENCOUNTER_S3_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]                 INT          CONSTRAINT [DF_PATIENT_ENCOUNTER_S3_UpdatedBy] DEFAULT ((0)) NULL,
    [ImportedDate]              DATETIME     CONSTRAINT [DF_PATIENT_ENCOUNTER_S3_ImportedDate] DEFAULT (getdate()) NULL,
    [ImportUpdateDate]          DATETIME     CONSTRAINT [DF_PATIENT_ENCOUNTER_S3_ImportUpdateDate] DEFAULT (getdate()) NULL,
    [Cancelled]                 BIT          CONSTRAINT [DF_PATIENT_ENCOUNTER_S3_Cancelled] DEFAULT ((0)) NULL,
    [IsInpatient]               BIT          NULL,
    CONSTRAINT [PK_PATIENT_ENCOUNTER_S3] PRIMARY KEY CLUSTERED ([PatientEncounterSurgeryId] ASC)
);

