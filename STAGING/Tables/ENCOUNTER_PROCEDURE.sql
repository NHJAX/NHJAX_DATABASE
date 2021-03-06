﻿CREATE TABLE [dbo].[ENCOUNTER$PROCEDURE] (
    [KEY_SITE]                  NUMERIC (5)     NULL,
    [KEY_ENCOUNTER]             VARCHAR (1)     NULL,
    [KEY_ENCOUNTER$PROCEDURE]   VARCHAR (1)     NULL,
    [PROCEDURE_IEN]             NUMERIC (21, 3) NULL,
    [PROVIDER_OF_PROCEDURE_IEN] NUMERIC (21, 3) NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ind_ENCOUNTER$PROCEDURE]
    ON [dbo].[ENCOUNTER$PROCEDURE]([KEY_SITE] ASC, [KEY_ENCOUNTER] ASC, [KEY_ENCOUNTER$PROCEDURE] ASC);

