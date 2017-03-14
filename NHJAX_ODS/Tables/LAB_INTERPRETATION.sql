CREATE TABLE [dbo].[LAB_INTERPRETATION] (
    [LabInterpretationId]   BIGINT         IDENTITY (1, 1) NOT NULL,
    [LabInterpretationKey]  NUMERIC (7, 3) NULL,
    [LabInterpretationDesc] VARCHAR (30)   NULL,
    [LabInterpretationCode] VARCHAR (2)    NULL,
    [CreatedDate]           DATETIME       CONSTRAINT [DF_LAB_INTERPRETATION_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]           DATETIME       CONSTRAINT [DF_LAB_INTERPRETATION_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_LAB_INTERPRETATION] PRIMARY KEY CLUSTERED ([LabInterpretationId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_LAB_INTERPRETATION_LabInterpretationKey]
    ON [dbo].[LAB_INTERPRETATION]([LabInterpretationKey] ASC);

