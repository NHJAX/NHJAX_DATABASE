CREATE TABLE [dbo].[ALLERGY] (
    [AllergyId]           BIGINT          IDENTITY (1, 1) NOT NULL,
    [AllergySelectionKey] DECIMAL (16, 3) NULL,
    [AllergyName]         VARCHAR (31)    NULL,
    [AllergyDesc]         VARCHAR (32)    NULL,
    [Comments]            VARCHAR (30)    NULL,
    [CreatedDate]         DATETIME        CONSTRAINT [DF_ALLERGY_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]         DATETIME        CONSTRAINT [DF_ALLERGY_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_ALLERGY] PRIMARY KEY CLUSTERED ([AllergyId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_ALLERGY_AllergySelectionKey]
    ON [dbo].[ALLERGY]([AllergySelectionKey] ASC);

