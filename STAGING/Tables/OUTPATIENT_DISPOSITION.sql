﻿CREATE TABLE [dbo].[OUTPATIENT_DISPOSITION] (
    [KEY_SITE]                   NUMERIC (5)    NULL,
    [KEY_OUTPATIENT_DISPOSITION] NUMERIC (8, 3) NULL,
    [CODE]                       VARCHAR (4)    NULL,
    [DESCRIPTION]                VARCHAR (30)   NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_OUTPATIENT_DISPOSITION_KEY_OUTPATIENT_DISPOSITION]
    ON [dbo].[OUTPATIENT_DISPOSITION]([KEY_OUTPATIENT_DISPOSITION] ASC) WITH (FILLFACTOR = 100);

