﻿CREATE TABLE [dbo].[BIT_BUCKET_AHLTA_MAMMOGRAPHY_ICD9] (
    [FMP Sponsor SSN]       NVARCHAR (255) NULL,
    [Full Name]             NVARCHAR (255) NULL,
    [Appointment Id]        FLOAT (53)     NULL,
    [Appointment Date/Time] DATETIME       NULL,
    [Appointment Status]    NVARCHAR (255) NULL,
    [Appointment Type]      NVARCHAR (255) NULL,
    [Encounter Id]          NVARCHAR (255) NULL,
    [ICD9 Code]             NVARCHAR (255) NULL,
    [FMP]                   NUMERIC (8, 3) NULL,
    [SponsorSSN]            VARCHAR (11)   NULL,
    [CreatedDate]           DATETIME       CONSTRAINT [DF_BIT_BUCKET_AHLTA_MAMMOGRAPHY_ICD9_CreatedDate] DEFAULT (getdate()) NULL
);

