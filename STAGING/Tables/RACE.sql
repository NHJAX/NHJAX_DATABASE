﻿CREATE TABLE [dbo].[RACE] (
    [KEY_SITE]    NUMERIC (5)    NULL,
    [KEY_RACE]    NUMERIC (7, 3) NULL,
    [DESCRIPTION] VARCHAR (32)   NULL,
    [CODE]        VARCHAR (1)    NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_RACE_KEY_RACE]
    ON [dbo].[RACE]([KEY_RACE] ASC) WITH (FILLFACTOR = 100);

