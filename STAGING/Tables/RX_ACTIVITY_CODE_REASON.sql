﻿CREATE TABLE [dbo].[RX_ACTIVITY_CODE_REASON] (
    [KEY_SITE]                    NUMERIC (5)    NULL,
    [KEY_RX_ACTIVITY_CODE_REASON] NUMERIC (9, 3) NULL,
    [REASON]                      VARCHAR (20)   NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ind_RX_ACTIVITY_CODE_REASON]
    ON [dbo].[RX_ACTIVITY_CODE_REASON]([KEY_SITE] ASC, [KEY_RX_ACTIVITY_CODE_REASON] ASC);

