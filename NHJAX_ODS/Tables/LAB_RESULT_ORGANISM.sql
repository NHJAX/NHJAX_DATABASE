CREATE TABLE [dbo].[LAB_RESULT_ORGANISM] (
    [LabResultOrganismId]         BIGINT          IDENTITY (1, 1) NOT NULL,
    [LabResultBacteriologyTestId] BIGINT          NULL,
    [EtiologyId]                  BIGINT          NULL,
    [LabResultOrganismKey]        NUMERIC (12, 3) NULL,
    [LabResultKey]                NUMERIC (13, 3) NULL,
    [LabResultSubKey]             NUMERIC (26, 9) NULL,
    [LabResultTestKey]            NUMERIC (10, 3) NULL,
    [CreatedDate]                 DATETIME        CONSTRAINT [DF_LAB_RESULT_ORGANISM_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_LAB_RESULT_ORGANISM] PRIMARY KEY CLUSTERED ([LabResultOrganismId] ASC),
    CONSTRAINT [FK_LAB_RESULT_ORGANISM_ETIOLOGY] FOREIGN KEY ([EtiologyId]) REFERENCES [dbo].[ETIOLOGY] ([EtiologyId]),
    CONSTRAINT [FK_LAB_RESULT_ORGANISM_LAB_RESULT_BACTERIOLOGY_TEST] FOREIGN KEY ([LabResultBacteriologyTestId]) REFERENCES [dbo].[LAB_RESULT_BACTERIOLOGY_TEST] ([LabResultBacteriologyTestId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_LAB_RESULT_ORGANISM_MultiKey]
    ON [dbo].[LAB_RESULT_ORGANISM]([LabResultBacteriologyTestId] ASC, [EtiologyId] ASC);

