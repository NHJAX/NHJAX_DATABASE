CREATE TABLE [dbo].[ANTIBIOTIC_SUSCEPTIBILITY] (
    [AntibioticSusceptibilityId]     BIGINT         IDENTITY (1, 1) NOT NULL,
    [AntibioticSusceptibilityKey]    NUMERIC (9, 3) NULL,
    [AntibioticSusceptibilityDesc]   VARCHAR (35)   NULL,
    [AntibioticSusceptibilityAbbrev] VARCHAR (3)    NULL,
    [CreatedDate]                    DATETIME       CONSTRAINT [DF_ANTIBIOTIC_SUSCEPTIBILITY_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]                    DATETIME       CONSTRAINT [DF_ANTIBIOTIC_SUSCEPTIBILITY_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_ANTIBIOTIC_SUSCEPTIBILITY] PRIMARY KEY CLUSTERED ([AntibioticSusceptibilityId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_ANTIBIOTIC_SUSCEPTIBILITY_AntibioticSusceptibilityKey]
    ON [dbo].[ANTIBIOTIC_SUSCEPTIBILITY]([AntibioticSusceptibilityKey] ASC);

