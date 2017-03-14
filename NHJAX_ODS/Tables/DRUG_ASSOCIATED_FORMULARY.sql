CREATE TABLE [dbo].[DRUG_ASSOCIATED_FORMULARY] (
    [DrugAssociatedFormularyId]   BIGINT          IDENTITY (1, 1) NOT NULL,
    [KeySite]                     NUMERIC (5)     NULL,
    [KeyDrug]                     NUMERIC (14, 3) NULL,
    [KeyDrug_AssociatedFormulary] NUMERIC (7, 3)  NULL,
    [AssociatedFormularyIEN]      NUMERIC (21, 3) NULL,
    [LocalCost]                   NUMERIC (18, 5) NULL,
    [PDTSUnitCost]                NUMERIC (18, 5) NULL,
    [Createddate]                 NCHAR (10)      CONSTRAINT [DF_DRUG_ASSOCIATED_FORMULARY_Createddate] DEFAULT (getdate()) NULL,
    [SourceSystemId]              INT             NULL
);

