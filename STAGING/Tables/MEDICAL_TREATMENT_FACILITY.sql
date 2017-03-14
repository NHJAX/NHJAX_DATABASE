CREATE TABLE [dbo].[MEDICAL_TREATMENT_FACILITY] (
    [KEY_SITE]                       NUMERIC (5)     NULL,
    [KEY_MEDICAL_TREATMENT_FACILITY] NUMERIC (11, 3) NULL,
    [NAME]                           VARCHAR (43)    NULL,
    [SHORT_NAME]                     VARCHAR (41)    NULL,
    [NON_MILITARY_FACILITY]          VARCHAR (30)    NULL,
    [DMIS_ID_IEN]                    NUMERIC (21, 3) NULL,
    [MTF_CODE]                       VARCHAR (7)     NULL,
    [UIC]                            VARCHAR (6)     NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ind_MEDICAL_TREATMENT_FACILITY]
    ON [dbo].[MEDICAL_TREATMENT_FACILITY]([KEY_SITE] ASC, [KEY_MEDICAL_TREATMENT_FACILITY] ASC);

