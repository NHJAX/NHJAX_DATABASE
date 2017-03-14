﻿CREATE TABLE [dbo].[ICD_DIAGNOSIS] (
    [KEY_SITE]          NUMERIC (5)     NULL,
    [KEY_ICD_DIAGNOSIS] NUMERIC (12, 3) NULL,
    [CODE_NUMBER]       VARCHAR (30)    NULL,
    [DIAGNOSIS]         VARCHAR (30)    NULL,
    [ICD_FLAG]          VARCHAR (5)     NULL,
    [DESCRIPTION]       VARCHAR (250)   NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_ICD_DIAGNOSIS_KEY_ICD_DIAGNOSIS]
    ON [dbo].[ICD_DIAGNOSIS]([KEY_ICD_DIAGNOSIS] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_ICD_DIAGNOSIS_CODE_NUMBER]
    ON [dbo].[ICD_DIAGNOSIS]([CODE_NUMBER] ASC) WITH (FILLFACTOR = 100);

