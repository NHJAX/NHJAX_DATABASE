CREATE TABLE [dbo].[PROVIDER_SPECIALTY] (
    [ProviderSpecialtyId]   BIGINT         IDENTITY (1, 1) NOT NULL,
    [ProviderSpecialtyKey]  NUMERIC (9, 3) NULL,
    [ProviderSpecialtyDesc] VARCHAR (60)   NULL,
    [ProviderSpecialtyCode] VARCHAR (30)   CONSTRAINT [DF_PROVIDER_SPECIALTY_ProviderSpecialtyCode] DEFAULT ((0)) NULL,
    [CreatedDate]           DATETIME       CONSTRAINT [DF_PROVIDER_SPECIALTY_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]           DATETIME       CONSTRAINT [DF_PROVIDER_SPECIALTY_UpdatedDate] DEFAULT (getdate()) NULL,
    [SourceSystemId]        INT            CONSTRAINT [DF_PROVIDER_SPECIALTY_SourceSystemId] DEFAULT ((2)) NULL,
    CONSTRAINT [PK_PROVIDER_SPECIALTY] PRIMARY KEY CLUSTERED ([ProviderSpecialtyId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_PROVIDER_SPECIALTY_ProviderSpecialtyDesc]
    ON [dbo].[PROVIDER_SPECIALTY]([ProviderSpecialtyDesc] ASC);

