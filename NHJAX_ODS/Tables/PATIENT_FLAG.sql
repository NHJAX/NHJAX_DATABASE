﻿CREATE TABLE [dbo].[PATIENT_FLAG] (
    [PatientFlagId]  BIGINT   IDENTITY (1, 1) NOT NULL,
    [PatientId]      BIGINT   NULL,
    [FlagId]         INT      NULL,
    [CreatedDate]    DATETIME CONSTRAINT [DF_PATIENT_FLAG_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]    DATETIME CONSTRAINT [DF_PATIENT_FLAG_UpdatedDate] DEFAULT (getdate()) NULL,
    [SourceSystemId] BIGINT   NULL,
    [Tracked]        BIGINT   CONSTRAINT [DF_PATIENT_FLAG_Tracked?] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_PATIENT_FLAG] PRIMARY KEY CLUSTERED ([PatientFlagId] ASC),
    CONSTRAINT [FK_PATIENT_FLAG_PATIENT] FOREIGN KEY ([PatientId]) REFERENCES [dbo].[PATIENT] ([PatientId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_PATIENT_FLAG_PatientId_FlagId_SourceSystemId]
    ON [dbo].[PATIENT_FLAG]([PatientId] ASC, [FlagId] ASC, [SourceSystemId] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_FLAG_FlagId]
    ON [dbo].[PATIENT_FLAG]([FlagId] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_FLAG_PatientId]
    ON [dbo].[PATIENT_FLAG]([PatientId] ASC);

