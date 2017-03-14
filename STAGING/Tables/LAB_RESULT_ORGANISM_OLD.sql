CREATE TABLE [dbo].[LAB_RESULT_ORGANISM_OLD] (
    [LabResultOrganismId]         BIGINT          IDENTITY (1, 1) NOT NULL,
    [LabResultOrganismKey]        NUMERIC (12, 3) NULL,
    [LabResultKey]                NUMERIC (10, 3) NULL,
    [LabResultSubKey]             NUMERIC (26, 9) NULL,
    [LabResultTestKey]            NUMERIC (10, 3) NULL,
    [LabResultBacteriologyTestId] BIGINT          NULL,
    [EtiologyId]                  BIGINT          NULL,
    [CreatedDate]                 DATETIME        CONSTRAINT [DF_LAB_RESULT_ORGANISM_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]                 DATETIME        CONSTRAINT [DF_LAB_RESULT_ORGANISM_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_LAB_RESULT_ORGANISM] PRIMARY KEY CLUSTERED ([LabResultOrganismId] ASC)
);

