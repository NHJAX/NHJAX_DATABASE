CREATE TABLE [dbo].[SPECIALTY] (
    [SpecialtyId]         BIGINT         IDENTITY (1, 1) NOT NULL,
    [SpecialtyKey]        NUMERIC (8, 3) NULL,
    [ProviderId]          BIGINT         NULL,
    [ProviderSpecialtyId] BIGINT         NULL,
    [CreatedDate]         DATETIME       CONSTRAINT [DF_SPECIALTY_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_SPECIALTY] PRIMARY KEY CLUSTERED ([SpecialtyId] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_SPECIALTY_MultiKey]
    ON [dbo].[SPECIALTY]([SpecialtyKey] ASC, [ProviderId] ASC);

