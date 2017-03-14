CREATE TABLE [dbo].[DRUG] (
    [KEY_SITE]                    NUMERIC (5)     NULL,
    [KEY_DRUG]                    NUMERIC (14, 3) NULL,
    [NAME]                        VARCHAR (40)    NULL,
    [PRIMARY_NDC_NUMBER_IEN]      NUMERIC (21, 3) NULL,
    [COMPONENT_THERAPEUTIC_CLASS] VARCHAR (40)    NULL,
    [AHFS_NUMBER]                 VARCHAR (53)    NULL,
    [AHFS_CLASSIFICATION]         VARCHAR (121)   NULL,
    [DEA_SPECIAL_HDLG]            VARCHAR (30)    NULL,
    [THERAPEUTIC_CLASS]           VARCHAR (108)   NULL,
    [METRIC_UNIT]                 VARCHAR (15)    NULL,
    [TMP_LOCAL_COST]              NUMERIC (16, 3) NULL,
    [TMP_PDTS_UNIT_COST]          NUMERIC (16, 3) NULL,
    [LABEL_PRINT_NAME]            VARCHAR (40)    NULL,
    [DOSAGE_STRENGTH]             NUMERIC (20, 5) NULL,
    [DRUG_ROUTE_FORM]             VARCHAR (15)    NULL,
    [ROUTE_IEN]                   NUMERIC (21, 3) NULL,
    [FORM_IEN]                    NUMERIC (21, 3) NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_DRUG_KEY_DRUG]
    ON [dbo].[DRUG]([KEY_DRUG] ASC) WITH (FILLFACTOR = 100);

