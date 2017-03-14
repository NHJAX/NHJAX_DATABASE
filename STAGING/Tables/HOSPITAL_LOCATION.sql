﻿CREATE TABLE [dbo].[HOSPITAL_LOCATION] (
    [KEY_SITE]              NUMERIC (5)     NULL,
    [KEY_HOSPITAL_LOCATION] NUMERIC (12, 4) NULL,
    [NAME]                  VARCHAR (30)    NULL,
    [DESCRIPTION]           VARCHAR (30)    NULL,
    [MTF_IEN]               NUMERIC (21, 3) NULL,
    [DIVISION_IEN]          NUMERIC (21, 3) NULL,
    [MEPRS_CODE_IEN]        NUMERIC (21, 3) NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_HOSPITAL_LOCATION_KEY_HOSPITAL_LOCATION]
    ON [dbo].[HOSPITAL_LOCATION]([KEY_HOSPITAL_LOCATION] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_HOSPITAL_LOCATION_MEPRS_CODE_IEN]
    ON [dbo].[HOSPITAL_LOCATION]([MEPRS_CODE_IEN] ASC) WITH (FILLFACTOR = 100);

