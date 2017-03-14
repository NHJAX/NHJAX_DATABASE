CREATE TABLE [dbo].[ETIOLOGY] (
    [EtiologyId]   BIGINT          IDENTITY (1, 1) NOT NULL,
    [EtiologyKey]  NUMERIC (12, 3) NULL,
    [EtiologyDesc] VARCHAR (70)    NULL,
    [CreatedDate]  DATETIME        CONSTRAINT [DF_ETIOLOGY_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]  DATETIME        CONSTRAINT [DF_ETIOLOGY_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_ETIOLOGY] PRIMARY KEY CLUSTERED ([EtiologyId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_ETIOLOGY_EtiologyKey]
    ON [dbo].[ETIOLOGY]([EtiologyKey] ASC);

