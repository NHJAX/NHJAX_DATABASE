CREATE TABLE [dbo].[PATIENT_DISPOSITION] (
    [PatientDispositionId]   BIGINT         IDENTITY (0, 1) NOT NULL,
    [PatientDispositionKey]  NUMERIC (8, 3) NULL,
    [PatientDispositionCode] VARCHAR (4)    NULL,
    [PatientDispositionDesc] VARCHAR (30)   NULL,
    [CreatedDate]            DATETIME       CONSTRAINT [DF_PATIENT_DISPOSITION_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]            DATETIME       CONSTRAINT [DF_PATIENT_DISPOSITION_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_PATIENT_DISPOSITION] PRIMARY KEY CLUSTERED ([PatientDispositionId] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_PATIENT_DISPOSITION_KEY]
    ON [dbo].[PATIENT_DISPOSITION]([PatientDispositionKey] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_DISPOSITION_PatientDispositionCode]
    ON [dbo].[PATIENT_DISPOSITION]([PatientDispositionCode] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_DISPOSITION_PATDISPID_PATDISPDESC]
    ON [dbo].[PATIENT_DISPOSITION]([PatientDispositionId] ASC, [PatientDispositionCode] ASC, [PatientDispositionDesc] ASC);

