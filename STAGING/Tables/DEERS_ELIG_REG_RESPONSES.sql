﻿CREATE TABLE [dbo].[DEERS_ELIG_REG_RESPONSES] (
    [KEY_SITE]                     NUMERIC (5)     NULL,
    [KEY_DEERS_ELIG_REG_RESPONSES] NUMERIC (13, 3) NULL,
    [DATE_OF_RESPONSE]             DATETIME        NULL,
    [DATE_POSTED]                  DATETIME        NULL,
    [TYPE_OF_RESPONSE]             VARCHAR (2)     NULL,
    [TYPE_OF_TRANSMISSION]         VARCHAR (5)     NULL,
    [PATIENT_IEN]                  NUMERIC (21, 3) NULL,
    [DATE_OF_BIRTH]                DATETIME        NULL,
    [ELIGIBILITY_START_DATE]       DATETIME        NULL,
    [ELIGIBILITY_END_DATE]         DATETIME        NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ind_DEERS_ELIG_REG_RESPONSES]
    ON [dbo].[DEERS_ELIG_REG_RESPONSES]([KEY_SITE] ASC, [KEY_DEERS_ELIG_REG_RESPONSES] ASC);

