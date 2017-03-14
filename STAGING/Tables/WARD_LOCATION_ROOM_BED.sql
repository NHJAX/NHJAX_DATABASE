﻿CREATE TABLE [dbo].[WARD_LOCATION$ROOM$BED] (
    [KEY_SITE]                   NUMERIC (5)     NULL,
    [KEY_WARD_LOCATION]          NUMERIC (11, 3) NULL,
    [KEY_WARD_LOCATION$ROOM$BED] NUMERIC (8, 3)  NULL,
    [KEY_WARD_LOCATION$ROOM]     NUMERIC (8, 3)  NULL,
    [BED]                        VARCHAR (2)     NULL,
    [STATUS]                     VARCHAR (30)    NULL,
    [PATIENT]                    VARCHAR (25)    NULL,
    [AVAILABLE]                  VARCHAR (30)    NULL,
    [BED_STATUS]                 VARCHAR (30)    NULL,
    [BED_SERVICE_IEN]            NUMERIC (21, 3) NULL,
    [SERVICE]                    VARCHAR (23)    NULL,
    [DESCRIPTION]                VARCHAR (30)    NULL,
    [PATIENT_RESERVED_FOR_IEN]   NUMERIC (21, 3) NULL,
    [PATIENT_OCCUPIED_BY_IEN]    NUMERIC (21, 3) NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ind_WARD_LOCATION$ROOM$BED]
    ON [dbo].[WARD_LOCATION$ROOM$BED]([KEY_SITE] ASC, [KEY_WARD_LOCATION] ASC, [KEY_WARD_LOCATION$ROOM$BED] ASC, [KEY_WARD_LOCATION$ROOM] ASC);

