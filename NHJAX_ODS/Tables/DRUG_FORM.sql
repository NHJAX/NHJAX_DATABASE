CREATE TABLE [dbo].[DRUG_FORM] (
    [DrugFormId]     BIGINT          NOT NULL,
    [DrugFormKey]    NUMERIC (8, 3)  NULL,
    [DrugFormName]   VARCHAR (5)     NULL,
    [DrugFormDesc]   VARCHAR (50)    NULL,
    [MediphorCode]   VARCHAR (4)     NULL,
    [FormCalculable] VARCHAR (30)    NULL,
    [UnitMinimum]    NUMERIC (18, 8) NULL,
    [UnitType]       VARCHAR (30)    NULL,
    [CreatedDate]    DATETIME        CONSTRAINT [DF_DRUG_FORM_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_DRUG_FORM] PRIMARY KEY CLUSTERED ([DrugFormId] ASC)
);

