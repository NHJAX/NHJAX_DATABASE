CREATE TABLE [dbo].[DRUG$SYNONYM$NDC_CODES] (
    [KEY_SITE]                   NUMERIC (5)     NULL,
    [KEY_DRUG]                   NUMERIC (14, 3) NULL,
    [KEY_DRUG$SYNONYM$NDC_CODES] NUMERIC (7, 3)  NULL,
    [KEY_DRUG$SYNONYM]           NUMERIC (7, 3)  NULL,
    [NDC_CODES]                  VARCHAR (20)    NULL
);

