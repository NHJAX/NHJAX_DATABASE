﻿CREATE TABLE [dbo].[COLLECTION_SAMPLE] (
    [KEY_SITE]              NUMERIC (5)    NULL,
    [KEY_COLLECTION_SAMPLE] NUMERIC (9, 3) NULL,
    [NAME]                  VARCHAR (30)   NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_COLLECTION_SAMPLE_KEY_COLLECTION_SAMPLE]
    ON [dbo].[COLLECTION_SAMPLE]([KEY_COLLECTION_SAMPLE] ASC) WITH (FILLFACTOR = 100);

