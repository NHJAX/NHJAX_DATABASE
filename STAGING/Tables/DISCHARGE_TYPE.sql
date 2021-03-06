﻿CREATE TABLE [dbo].[DISCHARGE_TYPE] (
    [KEY_SITE]           NUMERIC (5)    NULL,
    [KEY_DISCHARGE_TYPE] NUMERIC (9, 4) NULL,
    [NAME]               VARCHAR (60)   NULL,
    [CODE]               VARCHAR (2)    NULL,
    [ACTIVE]             VARCHAR (30)   NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_DISCHARGE_TYPE_KEY_DISCHARGE_TYPE]
    ON [dbo].[DISCHARGE_TYPE]([KEY_DISCHARGE_TYPE] ASC) WITH (FILLFACTOR = 100);

