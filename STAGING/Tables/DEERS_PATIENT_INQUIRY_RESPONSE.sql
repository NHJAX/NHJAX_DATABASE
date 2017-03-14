﻿CREATE TABLE [dbo].[DEERS_PATIENT_INQUIRY_RESPONSE] (
    [KEY_SITE]                           NUMERIC (5)     NULL,
    [KEY_DEERS_PATIENT_INQUIRY_RESPONSE] NUMERIC (12, 3) NULL,
    [MESSAGE_ID]                         VARCHAR (20)    NULL,
    [PATIENT_IEN]                        NUMERIC (21, 3) NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ind_DEERS_PATIENT_INQUIRY_RESPONSE]
    ON [dbo].[DEERS_PATIENT_INQUIRY_RESPONSE]([KEY_SITE] ASC, [KEY_DEERS_PATIENT_INQUIRY_RESPONSE] ASC);

