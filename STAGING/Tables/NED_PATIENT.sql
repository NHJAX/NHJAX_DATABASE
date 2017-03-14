﻿CREATE TABLE [dbo].[NED_PATIENT] (
    [KEY_SITE]         NUMERIC (5)     NULL,
    [KEY_NED_PATIENT]  NUMERIC (13, 3) NULL,
    [PATIENT_NAME_IEN] NUMERIC (21, 3) NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ind_NED_PATIENT]
    ON [dbo].[NED_PATIENT]([KEY_SITE] ASC, [KEY_NED_PATIENT] ASC);
