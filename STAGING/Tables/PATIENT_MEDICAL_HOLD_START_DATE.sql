﻿CREATE TABLE [dbo].[PATIENT$MEDICAL_HOLD_START_DATE] (
    [KEY_SITE]                            NUMERIC (5)     NULL,
    [KEY_PATIENT]                         NUMERIC (12, 3) NULL,
    [KEY_PATIENT$MEDICAL_HOLD_START_DATE] NUMERIC (7, 3)  NULL,
    [MEDICAL_HOLD_START_DATE]             DATETIME        NULL,
    [MEDICAL_HOLD_RELEASE_DATE]           DATETIME        NULL,
    [MEPRS_SERVICE_IEN]                   NUMERIC (21, 3) NULL,
    [PRIMARY_PHYSICIAN_IEN]               NUMERIC (21, 3) NULL,
    [DIAGNOSIS]                           VARCHAR (38)    NULL,
    [DIVISION_IEN]                        NUMERIC (21, 3) NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ind_PATIENT$MEDICAL_HOLD_START_DATE]
    ON [dbo].[PATIENT$MEDICAL_HOLD_START_DATE]([KEY_SITE] ASC, [KEY_PATIENT] ASC, [KEY_PATIENT$MEDICAL_HOLD_START_DATE] ASC);

