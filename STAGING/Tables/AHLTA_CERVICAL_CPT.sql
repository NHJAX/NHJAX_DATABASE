﻿CREATE TABLE [dbo].[AHLTA_CERVICAL_CPT] (
    [FMP Sponsor SSN]       NVARCHAR (255) NULL,
    [Full Name]             NVARCHAR (255) NULL,
    [Appointment Id]        FLOAT (53)     NULL,
    [Appointment Date/Time] DATETIME       NULL,
    [Appointment Status]    NVARCHAR (255) NULL,
    [Appointment Type]      NVARCHAR (255) NULL,
    [Encounter Id]          NVARCHAR (255) NULL,
    [CPT4 Code]             NVARCHAR (255) NULL,
    [FMP]                   NUMERIC (8, 3) NULL,
    [SponsorSSN]            VARCHAR (11)   NULL
);

