﻿CREATE TABLE [dbo].[MESSAGE$RECIPIENT] (
    [KEY_SITE]              NUMERIC (5)     NULL,
    [KEY_MESSAGE]           NUMERIC (14, 3) NULL,
    [KEY_MESSAGE$RECIPIENT] NUMERIC (9, 3)  NULL,
    [RECIPIENT]             VARCHAR (129)   NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ind_MESSAGE$RECIPIENT]
    ON [dbo].[MESSAGE$RECIPIENT]([KEY_SITE] ASC, [KEY_MESSAGE] ASC, [KEY_MESSAGE$RECIPIENT] ASC);

