CREATE TABLE [dbo].[ENCOUNTER_PROVIDER] (
    [EncounterProviderId] BIGINT   IDENTITY (1, 1) NOT NULL,
    [PatientEncounterId]  BIGINT   NULL,
    [ProviderId]          BIGINT   NULL,
    [ProviderRoleId]      BIGINT   NULL,
    [CreatedDate]         DATETIME CONSTRAINT [DF_ENCOUNTER_PROVIDER_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_ENCOUNTER_PROVIDER] PRIMARY KEY CLUSTERED ([EncounterProviderId] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_ENCOUNTER_PROVIDER_MultiKey]
    ON [dbo].[ENCOUNTER_PROVIDER]([PatientEncounterId] ASC, [ProviderId] ASC, [ProviderRoleId] ASC);

