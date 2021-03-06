﻿CREATE TABLE [dbo].[DEERS_MAILER] (
    [KEY_SITE]            NUMERIC (5)     NULL,
    [KEY_DEERS_MAILER]    NUMERIC (13, 3) NULL,
    [PATIENT_IEN]         NUMERIC (21, 3) NULL,
    [PATIENT_NAME]        VARCHAR (30)    NULL,
    [SPONSOR_POINTER_IEN] NUMERIC (21, 3) NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ind_DEERS_MAILER]
    ON [dbo].[DEERS_MAILER]([KEY_SITE] ASC, [KEY_DEERS_MAILER] ASC);

