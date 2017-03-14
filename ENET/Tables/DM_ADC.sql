CREATE TABLE [dbo].[DM_ADC] (
    [SessionKey]                 VARCHAR (50)   NULL,
    [DMCreatedDate]              DATETIME       CONSTRAINT [DF_DM_ADC_CreatedDate] DEFAULT (getdate()) NULL,
    [ActiveDirectoryComputerId]  BIGINT         NULL,
    [CommonName]                 VARCHAR (50)   NULL,
    [OperatingSystem]            VARCHAR (50)   NULL,
    [OperatingSystemServicePack] VARCHAR (50)   NULL,
    [LastLogon]                  DATETIME       NULL,
    [OperatingSystemVersion]     VARCHAR (50)   NULL,
    [DNSHostName]                VARCHAR (50)   NULL,
    [Location]                   VARCHAR (50)   NULL,
    [distinguishedName]          VARCHAR (255)  NULL,
    [CreatedDate]                DATETIME       NULL,
    [UpdatedDate]                DATETIME       NULL,
    [LastReportedDate]           DATETIME       NULL,
    [DeletedDate]                DATETIME       NULL,
    [DispositionDesc]            VARCHAR (50)   NULL,
    [Remarks]                    VARCHAR (1000) NULL,
    [LastReportedDays]           INT            NULL,
    [DispositionId]              INT            NULL,
    [IsHidden]                   BIT            NULL
);


GO
CREATE CLUSTERED INDEX [IX_DM_ADC_SessionKey]
    ON [dbo].[DM_ADC]([SessionKey] ASC);

