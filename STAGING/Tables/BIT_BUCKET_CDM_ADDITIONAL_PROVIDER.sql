CREATE TABLE [dbo].[BIT_BUCKET_CDM_ADDITIONAL_PROVIDER] (
    [Appointment Id]            FLOAT (53)     NULL,
    [Appointment Date/Time]     DATETIME       NULL,
    [FMP Sponsor SSN]           NVARCHAR (255) NULL,
    [Appointment Provider Role] NVARCHAR (255) NULL,
    [Additional Provider]       NVARCHAR (255) NULL,
    [FMP]                       NVARCHAR (255) NULL,
    [Sponsor SSN]               NVARCHAR (255) NULL,
    [Full Name]                 NVARCHAR (255) NULL,
    [DOB]                       DATETIME       NULL,
    [CreatedDate]               DATETIME       CONSTRAINT [DF_BIT_BUCKET_CDM_ADDITIONAL_PROVIDER_CreatedDate] DEFAULT (getdate()) NULL
);

