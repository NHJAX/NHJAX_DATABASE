CREATE TABLE [dbo].[ESS_PATCOMMON] (
    [PatientKey]    BIGINT         NULL,
    [EssPatientKey] BIGINT         NULL,
    [HospNo]        NVARCHAR (50)  NULL,
    [ProviderName]  NVARCHAR (50)  NULL,
    [MoveTime]      DATETIME       NULL,
    [EditTime]      DATETIME       NULL,
    [Unit]          NVARCHAR (100) NULL,
    [BedName]       NVARCHAR (100) NULL,
    [AdmTime]       DATETIME       NULL,
    [CreatedDate]   DATETIME       CONSTRAINT [DF_ESS_PATCOMMON_CreatedDate] DEFAULT (getdate()) NULL
);

