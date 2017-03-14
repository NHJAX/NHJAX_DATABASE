﻿CREATE TABLE [dbo].[DRUG_NAME_FORM] (
    [KEY_SITE]           NUMERIC (5)     NULL,
    [KEY_DRUG_NAME_FORM] NUMERIC (8, 3)  NULL,
    [NAME]               VARCHAR (5)     NULL,
    [DESCRIPTION]        VARCHAR (50)    NULL,
    [MEDIPHOR_CODE]      VARCHAR (4)     NULL,
    [FORM_CALCULABLE]    VARCHAR (30)    NULL,
    [UNIT_MINIMUM]       NUMERIC (18, 8) NULL,
    [UNIT_TYPE]          VARCHAR (30)    NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ind_DRUG_NAME_FORM]
    ON [dbo].[DRUG_NAME_FORM]([KEY_SITE] ASC, [KEY_DRUG_NAME_FORM] ASC);

