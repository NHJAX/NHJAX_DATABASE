CREATE TABLE [dbo].[COLLECTION_SAMPLE] (
    [CollectionSampleId]   BIGINT         IDENTITY (1, 1) NOT NULL,
    [CollectionSampleKey]  NUMERIC (9, 3) NULL,
    [CollectionSampleDesc] VARCHAR (30)   NULL,
    [CreatedDate]          DATETIME       CONSTRAINT [DF_COLLECTION_SAMPLE_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]          DATETIME       CONSTRAINT [DF_COLLECTION_SAMPLE_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_COLLECTION_SAMPLE] PRIMARY KEY CLUSTERED ([CollectionSampleId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_COLLECTION_SAMPLE_CollectionSampleKey]
    ON [dbo].[COLLECTION_SAMPLE]([CollectionSampleKey] ASC);

