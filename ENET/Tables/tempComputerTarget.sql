﻿CREATE TABLE [dbo].[tempComputerTarget] (
    [TargetID]                 INT            NOT NULL,
    [ComputerID]               NVARCHAR (256) NOT NULL,
    [SID]                      VARBINARY (85) NULL,
    [LastSyncTime]             DATETIME       NULL,
    [LastReportedStatusTime]   DATETIME       NULL,
    [LastReportedRebootTime]   DATETIME       NULL,
    [IPAddress]                NVARCHAR (40)  NULL,
    [FullDomainName]           NVARCHAR (255) NULL,
    [OSMajorVersion]           INT            NULL,
    [OSMinorVersion]           INT            NULL,
    [OSBuildNumber]            INT            NULL,
    [OSServicePackMajorNumber] INT            NULL,
    [OSServicePackMinorNumber] INT            NULL,
    [OSLocale]                 NVARCHAR (10)  NULL,
    [ComputerMake]             NVARCHAR (64)  NULL,
    [ComputerModel]            NVARCHAR (64)  NULL,
    [BiosVersion]              NVARCHAR (64)  NULL,
    [BiosName]                 NVARCHAR (64)  NULL,
    [BiosReleaseDate]          DATETIME       NULL,
    [ProcessorArchitecture]    NVARCHAR (50)  NULL,
    [IsRegistered]             BIT            NOT NULL,
    [CreatedDate]              DATETIME       NULL
);

