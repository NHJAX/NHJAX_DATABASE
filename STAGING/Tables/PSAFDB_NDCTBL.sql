CREATE TABLE [dbo].[PSAFDB_NDCTBL] (
    [KEY_SITE]          NUMERIC (5)     NULL,
    [KEY_PSAFDB_NDCTBL] NUMERIC (17, 3) NULL,
    [NUMBER_]           NUMERIC (17, 3) NULL,
    [GCNSEQNO_IEN]      NUMERIC (21, 3) NULL,
    [BN]                VARCHAR (30)    NULL,
    [AD]                VARCHAR (20)    NULL,
    [LN]                VARCHAR (30)    NULL,
    [MEDICAL_SUPPLY]    VARCHAR (30)    NULL,
    [DEA]               VARCHAR (30)    NULL,
    [CL]                VARCHAR (30)    NULL,
    [DF]                VARCHAR (30)    NULL,
    [PACKAGE_SIZE]      NUMERIC (12, 3) NULL,
    [OBSDTE]            DATETIME        NULL,
    [DADDCT]            DATETIME        NULL,
    [DACCESCT]          DATETIME        NULL,
    [PNDC_IEN]          NUMERIC (21, 3) NULL,
    [REPNDC_IEN]        NUMERIC (21, 3) NULL,
    [DELETE_DATE]       DATETIME        NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ind_PSAFDB_NDCTBL]
    ON [dbo].[PSAFDB_NDCTBL]([KEY_SITE] ASC, [KEY_PSAFDB_NDCTBL] ASC);

