﻿CREATE TABLE [dbo].[PATIENT_ACTIVITY] (
    [PatientId]   BIGINT   NOT NULL,
    [CreatedDate] DATETIME CONSTRAINT [DF_PATIENT_ACTIVITY_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate] DATETIME CONSTRAINT [DF_PATIENT_ACTIVITY_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_PATIENT_ACTIVITY] PRIMARY KEY CLUSTERED ([PatientId] ASC)
);

