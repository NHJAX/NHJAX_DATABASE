CREATE TABLE [dbo].[PHARMACY] (
    [PharmacyId]   BIGINT       IDENTITY (1, 1) NOT NULL,
    [PharmacyDesc] VARCHAR (50) NULL,
    [CreatedDate]  DATETIME     CONSTRAINT [DF_PHARMACY_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_PHARMACY] PRIMARY KEY CLUSTERED ([PharmacyId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_PHARMACY_PharmacyId,PharmacyDesc]
    ON [dbo].[PHARMACY]([PharmacyId] ASC, [PharmacyDesc] ASC);

