﻿CREATE TABLE [dbo].[TECHNICIAN_PREFERENCE] (
    [TechPrefId]     INT           IDENTITY (1, 1) NOT NULL,
    [TechnicianId]   INT           NOT NULL,
    [PreferenceId]   INT           NOT NULL,
    [PreferenceInfo] VARCHAR (100) NULL,
    [CreatedDate]    DATETIME      CONSTRAINT [DF_TECHNICIAN_PREFERENCE_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_TECHNICIAN_PREFERENCE] PRIMARY KEY CLUSTERED ([TechPrefId] ASC),
    CONSTRAINT [FK_TECHNICIAN_PREFERENCE_PREFERENCE] FOREIGN KEY ([PreferenceId]) REFERENCES [dbo].[PREFERENCE] ([PreferenceId]),
    CONSTRAINT [FK_TECHNICIAN_PREFERENCE_TECHNICIAN] FOREIGN KEY ([TechnicianId]) REFERENCES [dbo].[TECHNICIAN] ([UserId])
);

