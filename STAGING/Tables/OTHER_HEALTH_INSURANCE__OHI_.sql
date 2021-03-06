﻿CREATE TABLE [dbo].[OTHER_HEALTH_INSURANCE__OHI_] (
    [KEY_SITE]                         NUMERIC (5)     NULL,
    [KEY_OTHER_HEALTH_INSURANCE__OHI_] NUMERIC (13, 3) NULL,
    [PATIENT_IEN_IEN]                  NUMERIC (21, 3) NULL,
    [PATIENT_DATE_LAST_MODIFIED]       DATETIME        NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ind_OTHER_HEALTH_INSURANCE__OHI_]
    ON [dbo].[OTHER_HEALTH_INSURANCE__OHI_]([KEY_SITE] ASC, [KEY_OTHER_HEALTH_INSURANCE__OHI_] ASC);

