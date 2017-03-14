﻿CREATE TABLE [dbo].[PATIENT_APPOINTMENT$DIAGNOSIS] (
    [KEY_SITE]                          NUMERIC (5)     NULL,
    [KEY_PATIENT_APPOINTMENT]           VARCHAR (1)     NULL,
    [KEY_PATIENT_APPOINTMENT$DIAGNOSIS] VARCHAR (1)     NULL,
    [DIAGNOSIS]                         NUMERIC (7, 3)  NULL,
    [DIAGNOSIS__01_IEN]                 NUMERIC (21, 3) NULL,
    [DESCRIPTION]                       TEXT            NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ind_PATIENT_APPOINTMENT$DIAGNOSIS]
    ON [dbo].[PATIENT_APPOINTMENT$DIAGNOSIS]([KEY_SITE] ASC, [KEY_PATIENT_APPOINTMENT] ASC, [KEY_PATIENT_APPOINTMENT$DIAGNOSIS] ASC);

