﻿CREATE TABLE [dbo].[RELIGION] (
    [KEY_SITE]     NUMERIC (5)    NULL,
    [KEY_RELIGION] NUMERIC (8, 3) NULL,
    [NAME]         VARCHAR (70)   NULL,
    [CODE]         VARCHAR (4)    NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_RELIGION_KEY_RELIGION]
    ON [dbo].[RELIGION]([KEY_RELIGION] ASC) WITH (FILLFACTOR = 100);

