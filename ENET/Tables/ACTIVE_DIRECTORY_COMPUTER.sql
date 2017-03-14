CREATE TABLE [dbo].[ACTIVE_DIRECTORY_COMPUTER] (
    [ActiveDirectoryComputerId]  BIGINT         IDENTITY (1, 1) NOT NULL,
    [CommonName]                 VARCHAR (50)   NULL,
    [operatingSystem]            VARCHAR (50)   NULL,
    [operatingSystemServicePack] VARCHAR (50)   NULL,
    [lastLogon]                  DATETIME       NULL,
    [OperatingSystemVersion]     VARCHAR (50)   NULL,
    [DNSHostName]                VARCHAR (50)   NULL,
    [Location]                   VARCHAR (50)   NULL,
    [distinguishedName]          VARCHAR (255)  NULL,
    [CreatedDate]                DATETIME       CONSTRAINT [DF_ACTIVE_DIRECTORY_COMPUTER_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]                DATETIME       CONSTRAINT [DF_ACTIVE_DIRECTORY_COMPUTER_UpdatedDate] DEFAULT (getdate()) NULL,
    [LastReportedDate]           DATETIME       CONSTRAINT [DF_ACTIVE_DIRECTORY_COMPUTER_LastReportedDate] DEFAULT (getdate()) NULL,
    [DeletedDate]                DATETIME       CONSTRAINT [DF_ACTIVE_DIRECTORY_COMPUTER_DeletedDate] DEFAULT ('1/1/1776') NULL,
    [Remarks]                    VARCHAR (1000) NULL,
    [IsHidden]                   BIT            CONSTRAINT [DF_ACTIVE_DIRECTORY_COMPUTER_IsHidden] DEFAULT ((0)) NULL,
    [UpdatedBy]                  INT            CONSTRAINT [DF_ACTIVE_DIRECTORY_COMPUTER_UpdatedBy] DEFAULT ((0)) NULL,
    [ShareUpdatedDate]           DATETIME       NULL,
    CONSTRAINT [PK_ACTIVE_DIRECTORY_COMPUTER] PRIMARY KEY CLUSTERED ([ActiveDirectoryComputerId] ASC)
);

