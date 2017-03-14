﻿CREATE TABLE [dbo].[PHARMACY_PATIENT] (
    [KEY_SITE]             NUMERIC (5)     NULL,
    [KEY_PHARMACY_PATIENT] NUMERIC (13, 3) NULL,
    [NAME_IEN]             NUMERIC (21, 3) NULL,
    [PHARMACY_COMMENT]     VARCHAR (60)    NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_PHARMACY_PATIENT_KEY_PHARMACY_PATIENT]
    ON [dbo].[PHARMACY_PATIENT]([KEY_PHARMACY_PATIENT] ASC) WITH (FILLFACTOR = 100);

