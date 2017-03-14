CREATE TABLE [dbo].[PROVIDER_ROLE] (
    [ProviderRoleId]   BIGINT       IDENTITY (1, 1) NOT NULL,
    [ProviderRoleDesc] VARCHAR (50) NULL,
    [CreatedDate]      DATETIME     CONSTRAINT [DF_PROVIDER_ROLE_CreatedDate] DEFAULT (getdate()) NULL,
    [SourceSystemId]   BIGINT       CONSTRAINT [DF_PROVIDER_ROLE_SourceSystemId] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_PROVIDER_ROLE] PRIMARY KEY CLUSTERED ([ProviderRoleId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_PROVIDER_ROLE_ProviderRoleDesc]
    ON [dbo].[PROVIDER_ROLE]([ProviderRoleDesc] ASC);

