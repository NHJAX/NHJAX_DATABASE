CREATE TABLE [dbo].[DIAGNOSIS] (
    [DiagnosisId]    BIGINT          IDENTITY (0, 1) NOT NULL,
    [DiagnosisKey]   NUMERIC (11, 3) NULL,
    [DiagnosisCode]  VARCHAR (30)    NULL,
    [DiagnosisDesc]  VARCHAR (250)   NULL,
    [DiagnosisName]  VARCHAR (30)    NULL,
    [DiagnosisType]  BIGINT          NULL,
    [RelativeWeight] NUMERIC (18, 7) NULL,
    [CreatedDate]    DATETIME        CONSTRAINT [DF_DIAGNOSTIC_RELATED_GROUP_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]    DATETIME        CONSTRAINT [DF_DIAGNOSIS_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_DIAGNOSTIC_RELATED_GROUP] PRIMARY KEY CLUSTERED ([DiagnosisId] ASC),
    CONSTRAINT [FK_DIAGNOSIS_DIAGNOSIS_TYPE] FOREIGN KEY ([DiagnosisType]) REFERENCES [dbo].[DIAGNOSIS_TYPE] ([DiagnosisTypeId])
);


GO
CREATE NONCLUSTERED INDEX [IX_DIAGNOSIS_KEY]
    ON [dbo].[DIAGNOSIS]([DiagnosisKey] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DIAGNOSIS_Code]
    ON [dbo].[DIAGNOSIS]([DiagnosisCode] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DIAGONSIS_DiagnosisDesc]
    ON [dbo].[DIAGNOSIS]([DiagnosisDesc] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_DIAGNOSIS_Diagnosisid_diagnosiscode]
    ON [dbo].[DIAGNOSIS]([DiagnosisId] ASC, [DiagnosisCode] ASC);

