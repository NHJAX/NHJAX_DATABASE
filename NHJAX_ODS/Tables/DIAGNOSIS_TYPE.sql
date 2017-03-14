CREATE TABLE [dbo].[DIAGNOSIS_TYPE] (
    [DiagnosisTypeId]   BIGINT       NOT NULL,
    [DiagnosisTypeDesc] VARCHAR (50) NULL,
    [CreatedDate]       DATETIME     CONSTRAINT [DF_DIAGNOSIS_TYPE_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_DIAGNOSIS_TYPE] PRIMARY KEY CLUSTERED ([DiagnosisTypeId] ASC)
);

