﻿CREATE TABLE [dbo].[TECHNICIAN_EXTENDED_HISTORY] (
    [TechnicianExtendedHistoryId] BIGINT          IDENTITY (1, 1) NOT NULL,
    [UserId]                      INT             NULL,
    [ProviderId]                  BIGINT          NULL,
    [IsException]                 BIT             NULL,
    [CreatedDate]                 DATETIME        NULL,
    [UpdatedDate]                 DATETIME        NULL,
    [Deployed]                    BIT             NULL,
    [DeployDate]                  DATETIME        NULL,
    [ReturnDate]                  DATETIME        NULL,
    [UpdatedBy]                   INT             NULL,
    [HasAlt]                      BIT             NULL,
    [AltId]                       VARCHAR (25)    NULL,
    [AvailableForDisaster]        BIT             NULL,
    [HasServerAccess]             BIT             NULL,
    [ExcludeTrainingDept]         BIT             NULL,
    [TeamId]                      INT             NULL,
    [TimekeeperTypeId]            INT             NULL,
    [HasDriversLicense]           BIT             NULL,
    [AltIssueDate]                DATETIME        NULL,
    [ExcludeVolunteer]            BIT             NULL,
    [IsSupervisor]                BIT             NULL,
    [IsORM]                       BIT             NULL,
    [HistoryDate]                 DATETIME        CONSTRAINT [DF_TECHNICIAN_EXTENDED_HISTORY_HistoryDate] DEFAULT (getdate()) NULL,
    [HistoryBy]                   INT             CONSTRAINT [DF_TECHNICIAN_EXTENDED_HISTORY_HistoryBy] DEFAULT ((0)) NULL,
    [IsSupplyPO]                  BIT             NULL,
    [NPIKey]                      NUMERIC (16, 3) NULL,
    CONSTRAINT [PK_TECHNICIAN_EXTENDED_HISTORY] PRIMARY KEY CLUSTERED ([TechnicianExtendedHistoryId] ASC)
);
