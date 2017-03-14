﻿CREATE TABLE [dbo].[LAB_INTERPRETATION_FILE] (
    [KEY_SITE]                    NUMERIC (5)    NULL,
    [KEY_LAB_INTERPRETATION_FILE] NUMERIC (7, 3) NULL,
    [CODE]                        VARCHAR (2)    NULL,
    [DESCRIPTION]                 VARCHAR (30)   NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_LAB_INTERPRETATION_FILE_KEY_LAB_INTERPRETATION_FILE]
    ON [dbo].[LAB_INTERPRETATION_FILE]([KEY_LAB_INTERPRETATION_FILE] ASC) WITH (FILLFACTOR = 100);
