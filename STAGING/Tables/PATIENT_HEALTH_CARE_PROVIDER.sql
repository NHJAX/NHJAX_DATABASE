﻿CREATE TABLE [dbo].[PATIENT$HEALTH_CARE_PROVIDER] (
    [KEY_SITE]                         NUMERIC (5)     NULL,
    [KEY_PATIENT]                      VARCHAR (1)     NULL,
    [KEY_PATIENT$HEALTH_CARE_PROVIDER] VARCHAR (1)     NULL,
    [HEALTH_CARE_PROVIDER_IEN]         NUMERIC (21, 3) NULL,
    [LOCATION_IEN]                     NUMERIC (21, 3) NULL,
    [CLINICAL_SERVICE_IEN]             NUMERIC (21, 3) NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ind_PATIENT$HEALTH_CARE_PROVIDER]
    ON [dbo].[PATIENT$HEALTH_CARE_PROVIDER]([KEY_SITE] ASC, [KEY_PATIENT] ASC, [KEY_PATIENT$HEALTH_CARE_PROVIDER] ASC);

