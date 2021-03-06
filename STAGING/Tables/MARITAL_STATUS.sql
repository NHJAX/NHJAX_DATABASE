﻿CREATE TABLE [dbo].[MARITAL_STATUS] (
    [KEY_SITE]           NUMERIC (5)    NULL,
    [KEY_MARITAL_STATUS] NUMERIC (7, 3) NULL,
    [NAME]               VARCHAR (30)   NULL,
    [ABBREVIATION]       VARCHAR (5)    NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_MARITAL_STATUS_KEY_MARITAL_STATUS]
    ON [dbo].[MARITAL_STATUS]([KEY_MARITAL_STATUS] ASC) WITH (FILLFACTOR = 100);

