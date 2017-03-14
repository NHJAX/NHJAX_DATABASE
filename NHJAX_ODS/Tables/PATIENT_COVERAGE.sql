CREATE TABLE [dbo].[PATIENT_COVERAGE] (
    [PatientCoverageId]   BIGINT         IDENTITY (0, 1) NOT NULL,
    [PatientCoverageKey]  NUMERIC (9, 3) NULL,
    [PatientCoverageDesc] VARCHAR (125)  NULL,
    [PatientCoverageCode] VARCHAR (3)    NULL,
    [CreatedDate]         DATETIME       CONSTRAINT [DF_PATIENT_COVERAGE_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]         DATETIME       CONSTRAINT [DF_PATIENT_COVERAGE_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_PATIENT_COVERAGE] PRIMARY KEY CLUSTERED ([PatientCoverageId] ASC)
);

