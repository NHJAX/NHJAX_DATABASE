CREATE TABLE [dbo].[HEALTHCARE_STATUS] (
    [HealthcareStatusId]    INT           NULL,
    [HealthcareStatusDesc]  VARCHAR (100) NULL,
    [CreatedDate]           DATETIME      CONSTRAINT [DF_HEALTHCARE_STATUS_CreatedDate] DEFAULT (getdate()) NULL,
    [HealthCareStatusShort] VARCHAR (50)  NULL
);

