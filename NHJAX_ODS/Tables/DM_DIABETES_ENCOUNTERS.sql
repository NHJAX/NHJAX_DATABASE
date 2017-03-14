CREATE TABLE [dbo].[DM_DIABETES_ENCOUNTERS] (
    [DiabetesEncounterId] BIGINT        IDENTITY (1, 1) NOT NULL,
    [PatientId]           BIGINT        NOT NULL,
    [ProcedureDesc]       NVARCHAR (30) NULL,
    [ProcedureDate]       DATETIME      NOT NULL,
    [EncounterTypeId]     INT           NOT NULL,
    [SourcesystemId]      INT           NOT NULL,
    [CreatedDate]         DATETIME      CONSTRAINT [DF_DM_DIABETES_ENCOUNTERS_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [CPTCode]             NCHAR (10)    NULL,
    CONSTRAINT [PK_DM_DIABETES_ENCOUNTERS] PRIMARY KEY CLUSTERED ([DiabetesEncounterId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_DM_DIABETES_ENCOUNTERS_PatientId]
    ON [dbo].[DM_DIABETES_ENCOUNTERS]([PatientId] ASC, [EncounterTypeId] ASC);

