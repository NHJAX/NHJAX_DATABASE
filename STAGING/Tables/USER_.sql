﻿CREATE TABLE [dbo].[USER_] (
    [KEY_SITE]               NUMERIC (5)     NULL,
    [KEY_USER]               NUMERIC (12, 4) NULL,
    [NUMBER_]                NUMERIC (11, 3) NULL,
    [NAME]                   VARCHAR (30)    NULL,
    [TERMINATION_DATE]       DATETIME        NULL,
    [SSN]                    VARCHAR (30)    NULL,
    [LAST_SIGN_ON_DATE_TIME] VARCHAR (18)    NULL,
    [PROVIDER_IEN]           NUMERIC (21, 3) NULL
);


GO
CREATE CLUSTERED INDEX [IX_USER__TERMINATION_DATE]
    ON [dbo].[USER_]([TERMINATION_DATE] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_USER__KEY_USER]
    ON [dbo].[USER_]([KEY_USER] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_USER__PROVIDER_IEN]
    ON [dbo].[USER_]([PROVIDER_IEN] ASC) WITH (FILLFACTOR = 100);

