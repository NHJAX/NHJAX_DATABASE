CREATE TABLE [dbo].[SEVERITY_FLAG] (
    [PatientStatId]       BIGINT   NOT NULL,
    [PatientId]           BIGINT   NOT NULL,
    [DiseaseManagementId] BIGINT   NOT NULL,
    [CreatedDate]         DATETIME CONSTRAINT [DF_SEVERITY_FLAG_CreatedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_SEVERITY_FLAG] PRIMARY KEY CLUSTERED ([PatientStatId] ASC, [PatientId] ASC, [DiseaseManagementId] ASC)
);

