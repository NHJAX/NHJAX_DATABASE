CREATE TABLE [dbo].[ESS_TOBACCO_USE] (
    [KeyDate]       DATETIME      NULL,
    [PatientKey]    BIGINT        NULL,
    [EssPatientKey] BIGINT        NULL,
    [Tobacco]       NVARCHAR (50) NULL,
    [CreatedDate]   DATETIME      CONSTRAINT [DF_ESS_TOBACCO_USE_CreatedDate] DEFAULT (getdate()) NULL
);

