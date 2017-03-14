﻿CREATE TABLE [dbo].[KG_ADC_DATA$EVAL_MGMT_CODE] (
    [KEY_SITE]                       NUMERIC (5)     NULL,
    [KEY_KG_ADC_DATA]                NUMERIC (14, 3) NULL,
    [KEY_KG_ADC_DATA$EVAL_MGMT_CODE] NUMERIC (7, 3)  NULL,
    [EVAL_MGMT_CODE_IEN]             NUMERIC (21, 3) NULL,
    [DIAGNOSIS_PRIORITIES]           NUMERIC (10, 3) NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ind_KG_ADC_DATA$EVAL_MGMT_CODE]
    ON [dbo].[KG_ADC_DATA$EVAL_MGMT_CODE]([KEY_SITE] ASC, [KEY_KG_ADC_DATA] ASC, [KEY_KG_ADC_DATA$EVAL_MGMT_CODE] ASC);

