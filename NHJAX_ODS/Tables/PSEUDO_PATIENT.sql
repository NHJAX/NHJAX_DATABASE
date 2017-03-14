CREATE TABLE [dbo].[PSEUDO_PATIENT] (
    [PseudoPatientId]   INT          IDENTITY (0, 1) NOT NULL,
    [PseudoPatientDesc] VARCHAR (30) NULL,
    [CreatedDate]       DATETIME     CONSTRAINT [DF_PSEUDO_PATIENT_CODE_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_PSEUDO_PATIENT_CODE] PRIMARY KEY CLUSTERED ([PseudoPatientId] ASC)
);

