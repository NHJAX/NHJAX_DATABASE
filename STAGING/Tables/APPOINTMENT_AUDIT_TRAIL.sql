﻿CREATE TABLE [dbo].[APPOINTMENT_AUDIT_TRAIL] (
    [KEY_SITE]                    NUMERIC (5)     NULL,
    [KEY_APPOINTMENT_AUDIT_TRAIL] NUMERIC (14, 3) NULL,
    [PATIENT_NAME_IEN]            NUMERIC (21, 3) NULL,
    [CLERK_IEN]                   NUMERIC (22, 4) NULL,
    [TRANSACTION_DATE_TIME]       DATETIME        NULL,
    [APPOINTMENT_STATUS_IEN]      NUMERIC (21, 3) NULL,
    [DIVISION_IEN]                NUMERIC (21, 3) NULL,
    [CLINIC_IEN]                  NUMERIC (21, 3) NULL,
    [STATUS_MODIFIER]             VARCHAR (30)    NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ind_APPOINTMENT_AUDIT_TRAIL]
    ON [dbo].[APPOINTMENT_AUDIT_TRAIL]([KEY_SITE] ASC, [KEY_APPOINTMENT_AUDIT_TRAIL] ASC);

