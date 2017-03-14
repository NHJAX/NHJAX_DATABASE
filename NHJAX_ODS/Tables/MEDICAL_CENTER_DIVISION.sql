CREATE TABLE [dbo].[MEDICAL_CENTER_DIVISION] (
    [MedicalCenterDivisionId]   BIGINT         IDENTITY (1, 1) NOT NULL,
    [MedicalCenterDivisionKey]  NUMERIC (8, 3) NULL,
    [MedicalCenterDivisionDesc] VARCHAR (30)   NULL,
    [CreatedDate]               DATETIME       CONSTRAINT [DF_MEDICAL_CENTER_DIVISION_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]               DATETIME       CONSTRAINT [DF_MEDICAL_CENTER_DIVISION_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_MEDICAL_CENTER_DIVISION] PRIMARY KEY CLUSTERED ([MedicalCenterDivisionId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_MEDICAL_CENTER_DIVISION_MedicalCenterDivisionKey]
    ON [dbo].[MEDICAL_CENTER_DIVISION]([MedicalCenterDivisionKey] ASC);

