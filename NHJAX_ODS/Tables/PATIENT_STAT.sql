CREATE TABLE [dbo].[PATIENT_STAT] (
    [PatientStatId]   BIGINT       IDENTITY (1, 1) NOT NULL,
    [PatientStatDesc] VARCHAR (50) NULL,
    [CreatedDate]     DATETIME     CONSTRAINT [DF_PATIENT_STAT_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_PATIENT_STAT] PRIMARY KEY CLUSTERED ([PatientStatId] ASC)
);

