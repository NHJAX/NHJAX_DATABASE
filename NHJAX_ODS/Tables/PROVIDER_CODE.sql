CREATE TABLE [dbo].[PROVIDER_CODE] (
    [ProviderCodeId] BIGINT       IDENTITY (1, 1) NOT NULL,
    [ProviderId]     BIGINT       NULL,
    [ProviderCode]   VARCHAR (30) NULL,
    [CreatedDate]    DATETIME     CONSTRAINT [DF_PROVIDER_CODE_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_PROVIDER_CODE] PRIMARY KEY CLUSTERED ([ProviderCodeId] ASC),
    CONSTRAINT [FK_PROVIDER_CODE_PROVIDER] FOREIGN KEY ([ProviderId]) REFERENCES [dbo].[PROVIDER] ([ProviderId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_PROVIDER_CODE_ProviderId_ProviderCode]
    ON [dbo].[PROVIDER_CODE]([ProviderId] ASC, [ProviderCode] ASC);

