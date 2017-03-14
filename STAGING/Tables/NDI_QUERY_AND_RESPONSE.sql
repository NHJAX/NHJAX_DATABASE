CREATE TABLE [dbo].[NDI_QUERY_AND_RESPONSE] (
    [KEY_SITE]                   NUMERIC (5)     NULL,
    [KEY_NDI_QUERY_AND_RESPONSE] NUMERIC (14, 3) NULL,
    [DATE_TIME]                  DATETIME        NULL,
    [SENDER_IEN]                 NUMERIC (21, 3) NULL,
    [SOURCE_IEN]                 NUMERIC (21, 3) NULL,
    [PATIENT_IEN]                NUMERIC (21, 3) NULL,
    [PATIENT_NAME]               VARCHAR (30)    NULL,
    [PROVIDER_IEN]               NUMERIC (21, 3) NULL,
    [PERSON_IDENTIFER]           VARCHAR (9)     NULL,
    [DEERS_ID]                   VARCHAR (11)    NULL,
    [DOD_ID_#]                   VARCHAR (10)    NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ind_NDI_QUERY_AND_RESPONSE]
    ON [dbo].[NDI_QUERY_AND_RESPONSE]([KEY_SITE] ASC, [KEY_NDI_QUERY_AND_RESPONSE] ASC);

