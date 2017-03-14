﻿CREATE TABLE [dbo].[DM_ADA] (
    [SessionKey]               VARCHAR (50)  NULL,
    [DMCreatedDate]            DATETIME      CONSTRAINT [DF_DM_ADA_DMCreatedDate] DEFAULT (getdate()) NULL,
    [EmployeeId]               VARCHAR (50)  NULL,
    [DisplayName]              VARCHAR (150) NULL,
    [FirstName]                VARCHAR (50)  NULL,
    [MiddleName]               VARCHAR (50)  NULL,
    [LastName]                 VARCHAR (50)  NULL,
    [Description]              VARCHAR (50)  NULL,
    [EMail]                    VARCHAR (100) NULL,
    [LongUserName]             VARCHAR (150) NULL,
    [Title]                    VARCHAR (50)  NULL,
    [DirectorateDesc]          VARCHAR (50)  NULL,
    [BaseDesc]                 VARCHAR (50)  NULL,
    [LoginID]                  VARCHAR (50)  NOT NULL,
    [AudienceDesc]             VARCHAR (50)  NULL,
    [Phone]                    VARCHAR (50)  NULL,
    [Address1]                 VARCHAR (100) NULL,
    [Address2]                 VARCHAR (100) NULL,
    [City]                     VARCHAR (50)  NULL,
    [State]                    VARCHAR (2)   NULL,
    [Zip]                      VARCHAR (10)  NULL,
    [Country]                  VARCHAR (50)  NULL,
    [ADExpiresDate]            DATETIME      NULL,
    [ADLoginDate]              VARCHAR (50)  NULL,
    [distinguishedName]        VARCHAR (255) NULL,
    [Inactive]                 BIT           NOT NULL,
    [HomeDirectory]            VARCHAR (150) NULL,
    [HomeDrive]                VARCHAR (50)  NULL,
    [CreatedDate]              DATETIME      NOT NULL,
    [UpdatedDate]              DATETIME      NULL,
    [LastReportedDate]         DATETIME      NULL,
    [Remarks]                  TEXT          NULL,
    [SignedDate]               DATETIME      NULL,
    [SupervisorSignedDate]     DATETIME      NULL,
    [LBDate]                   DATETIME      NULL,
    [PSQDate]                  DATETIME      NULL,
    [CompletedDate]            DATETIME      NULL,
    [ActiveDirectoryAccountId] BIGINT        NOT NULL,
    [ServiceAccount]           BIT           NULL,
    [ADCreatedDate]            DATETIME      NULL,
    [UpdatedBy]                INT           NULL,
    [SSN]                      VARCHAR (11)  NULL,
    [ENetStatus]               INT           NULL,
    [IsHidden]                 BIT           NULL,
    [SecurityStatusId]         INT           NULL,
    [AlphaName]                VARCHAR (155) NULL,
    [DoDEDI]                   NVARCHAR (10) NULL
);


GO
CREATE CLUSTERED INDEX [IX_DM_ADA]
    ON [dbo].[DM_ADA]([SessionKey] ASC);
