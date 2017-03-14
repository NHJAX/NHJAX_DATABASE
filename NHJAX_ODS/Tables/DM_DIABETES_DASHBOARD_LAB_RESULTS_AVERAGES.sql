CREATE TABLE [dbo].[DM_DIABETES_DASHBOARD_LAB_RESULTS_AVERAGES] (
    [DashboardLabResultId] INT             IDENTITY (1, 1) NOT NULL,
    [ProviderId]           BIGINT          NOT NULL,
    [LabResultTypeId]      INT             NOT NULL,
    [AvgResult]            DECIMAL (18, 2) NOT NULL,
    [PatientCount]         INT             NOT NULL,
    [CreatedDate]          DATETIME        CONSTRAINT [DF_DM_DIABETES_DASHBOARD_LAB_RESULTS_AVERAGES_CreatedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_DM_DIABETES_DASHBOARD_LAB_RESULTS_AVERAGES] PRIMARY KEY CLUSTERED ([DashboardLabResultId] ASC)
);

