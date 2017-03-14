CREATE TABLE [dbo].[BENEFITS_CATEGORY] (
    [BenefitsCategoryId]   BIGINT         IDENTITY (0, 1) NOT NULL,
    [BenefitsCategoryKey]  NUMERIC (8, 3) NULL,
    [BenefitsCategoryDesc] VARCHAR (30)   NULL,
    [BenefitsCategoryCode] VARCHAR (30)   NULL,
    [CreatedDate]          DATETIME       CONSTRAINT [DF_BENEFITS_CATEGORY_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]          DATETIME       CONSTRAINT [DF_BENEFITS_CATEGORY_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_BENEFITS_CATEGORY] PRIMARY KEY CLUSTERED ([BenefitsCategoryId] ASC)
);

