CREATE TABLE [dbo].[DISEASE_SPECIFIC_DRUG] (
    [DiseaseSpecificDrugId]   BIGINT        IDENTITY (1, 1) NOT NULL,
    [DiseaseSpecificDrugDesc] VARCHAR (100) NOT NULL,
    [CreatedDate]             DATETIME      CONSTRAINT [DF_DISEASE_SPECIFIC_DRUG_CreatedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_DISEASE_SPECIFIC_DRUG] PRIMARY KEY CLUSTERED ([DiseaseSpecificDrugId] ASC)
);

