CREATE TABLE [dbo].[DM_DIABETES_LAB_RESULTS] (
    [DiabetesLabResultId] BIGINT     IDENTITY (1, 1) NOT NULL,
    [PatientId]           BIGINT     NOT NULL,
    [LabResultTypeId]     INT        NOT NULL,
    [DateTaken]           DATETIME   NULL,
    [Result]              NCHAR (19) NULL,
    [SourceSystemId]      INT        NOT NULL,
    [CreatedDate]         DATETIME   CONSTRAINT [DF_DM_DIABETES_LAB_RESULTS_CreatedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_DM_DIABETES_LAB_RESULTS] PRIMARY KEY CLUSTERED ([DiabetesLabResultId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_DM_DIABETES_LAB_RESULTS_PatientId]
    ON [dbo].[DM_DIABETES_LAB_RESULTS]([PatientId] ASC, [LabResultTypeId] ASC, [Result] ASC);

