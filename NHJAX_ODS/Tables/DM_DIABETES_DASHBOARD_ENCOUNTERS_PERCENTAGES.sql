CREATE TABLE [dbo].[DM_DIABETES_DASHBOARD_ENCOUNTERS_PERCENTAGES] (
    [DashboardEncounterId] INT      IDENTITY (1, 1) NOT NULL,
    [ProviderId]           BIGINT   NOT NULL,
    [EncounterTypeId]      INT      NOT NULL,
    [PercentCompleted]     INT      NOT NULL,
    [PercentNeeded]        INT      NOT NULL,
    [PatientCount]         INT      NOT NULL,
    [CreatedDate]          DATETIME CONSTRAINT [DF_DM_DIABETES_DASHBOARD_ENCOUNTERS_PERCENTAGES_CreatedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_DM_DIABETES_DASHBOARD_ENCOUNTERS_PERCENTAGES] PRIMARY KEY CLUSTERED ([DashboardEncounterId] ASC)
);

