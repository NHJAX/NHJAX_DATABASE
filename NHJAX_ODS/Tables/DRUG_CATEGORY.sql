CREATE TABLE [dbo].[DRUG_CATEGORY] (
    [DrugCategoryId]        BIGINT   IDENTITY (1, 1) NOT NULL,
    [DiseaseManagementId]   BIGINT   NOT NULL,
    [CreatedDate]           DATETIME CONSTRAINT [DF_DRUG_CATEGORY_CreatedDate] DEFAULT (getdate()) NULL,
    [ModifiedDate]          DATETIME CONSTRAINT [DF_DRUG_CATEGORY_ModifiedDate] DEFAULT (getdate()) NULL,
    [DiseaseSpecificDrugId] BIGINT   NULL,
    CONSTRAINT [PK_DRUG_CATEGORY] PRIMARY KEY CLUSTERED ([DrugCategoryId] ASC),
    CONSTRAINT [FK_DRUG_CATEGORY_DISEASE_MANAGEMENT] FOREIGN KEY ([DiseaseManagementId]) REFERENCES [dbo].[DISEASE_MANAGEMENT] ([DiseaseManagementId]),
    CONSTRAINT [FK_DRUG_CATEGORY_DISEASE_SPECIFIC_DRUG] FOREIGN KEY ([DiseaseSpecificDrugId]) REFERENCES [dbo].[DISEASE_SPECIFIC_DRUG] ([DiseaseSpecificDrugId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_DRUG_CATEGORY_DiseaseManagementId_DiseaseSpecificDrugId]
    ON [dbo].[DRUG_CATEGORY]([DiseaseManagementId] ASC, [DiseaseSpecificDrugId] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);

