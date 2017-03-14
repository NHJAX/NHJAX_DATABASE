CREATE TABLE [dbo].[DEERS_PATIENT_INQUIRY_COLLECTION] (
    [KEY_SITE]                             NUMERIC (5)     NULL,
    [KEY_DEERS_PATIENT_INQUIRY_COLLECTION] NUMERIC (12, 3) NULL,
    [MESSAGE_ID]                           VARCHAR (20)    NULL,
    [USER_IEN]                             NUMERIC (22, 4) NULL,
    [DIVISION_IEN]                         NUMERIC (21, 3) NULL,
    [PATIENT_IEN_IEN]                      NUMERIC (21, 3) NULL,
    [PERSON_ID]                            VARCHAR (10)    NULL,
    [PERSON_LAST_NAME]                     VARCHAR (26)    NULL,
    [PATIENT_NAME]                         VARCHAR (30)    NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ind_DEERS_PATIENT_INQUIRY_COLLECTION]
    ON [dbo].[DEERS_PATIENT_INQUIRY_COLLECTION]([KEY_SITE] ASC, [KEY_DEERS_PATIENT_INQUIRY_COLLECTION] ASC);

