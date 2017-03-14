CREATE TABLE [dbo].[LAB_RESULT_ANTIBIOTIC] (
    [LabResultAntibioticId]      BIGINT         IDENTITY (1, 1) NOT NULL,
    [LabResultOrganismId]        BIGINT         NULL,
    [AntibioticSusceptibilityId] BIGINT         NULL,
    [LabInterpretationId]        BIGINT         NULL,
    [Sensitivity]                VARCHAR (10)   NULL,
    [LabResultAntibioticKey]     NUMERIC (9, 3) NULL,
    [CreatedDate]                DATETIME       CONSTRAINT [DF_LAB_RESULT_ANTIBIOTIC_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]                DATETIME       CONSTRAINT [DF_LAB_RESULT_ANTIBIOTIC_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_LAB_RESULT_ANTIBIOTIC] PRIMARY KEY CLUSTERED ([LabResultAntibioticId] ASC),
    CONSTRAINT [FK_LAB_RESULT_ANTIBIOTIC_ANTIBIOTIC_SUSCEPTIBILITY] FOREIGN KEY ([AntibioticSusceptibilityId]) REFERENCES [dbo].[ANTIBIOTIC_SUSCEPTIBILITY] ([AntibioticSusceptibilityId]),
    CONSTRAINT [FK_LAB_RESULT_ANTIBIOTIC_ANTIBIOTIC_SUSCEPTIBILITY1] FOREIGN KEY ([AntibioticSusceptibilityId]) REFERENCES [dbo].[ANTIBIOTIC_SUSCEPTIBILITY] ([AntibioticSusceptibilityId]),
    CONSTRAINT [FK_LAB_RESULT_ANTIBIOTIC_LAB_INTERPRETATION] FOREIGN KEY ([LabInterpretationId]) REFERENCES [dbo].[LAB_INTERPRETATION] ([LabInterpretationId]),
    CONSTRAINT [FK_LAB_RESULT_ANTIBIOTIC_LAB_RESULT_ORGANISM] FOREIGN KEY ([LabResultOrganismId]) REFERENCES [dbo].[LAB_RESULT_ORGANISM] ([LabResultOrganismId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_LAB_RESULT_ANTIBIOTIC_MultiKey]
    ON [dbo].[LAB_RESULT_ANTIBIOTIC]([LabResultOrganismId] ASC, [AntibioticSusceptibilityId] ASC, [LabInterpretationId] ASC);

