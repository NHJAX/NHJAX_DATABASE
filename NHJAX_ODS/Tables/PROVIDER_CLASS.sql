CREATE TABLE [dbo].[PROVIDER_CLASS] (
    [ProviderClassId]     BIGINT          IDENTITY (0, 1) NOT NULL,
    [ProviderClassKey]    NUMERIC (10, 3) NULL,
    [ProviderClassDesc]   VARCHAR (30)    NULL,
    [ProviderClassAbbrev] VARCHAR (5)     NULL,
    [CreatedDate]         DATETIME        CONSTRAINT [DF_PROVIDER_CLASS_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]         DATETIME        CONSTRAINT [DF_PROVIDER_CLASS_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_PROVIDER_CLASS] PRIMARY KEY CLUSTERED ([ProviderClassId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_PROVIDER_CLASS_ID]
    ON [dbo].[PROVIDER_CLASS]([ProviderClassKey] ASC);

