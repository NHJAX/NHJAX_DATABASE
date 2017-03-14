CREATE TABLE [dbo].[MAIL_MESSAGE_SEARCH] (
    [KEY_SITE]                NUMERIC (5)     NULL,
    [KEY_MAIL_MESSAGE_SEARCH] NUMERIC (16, 3) NULL,
    [MAIL_BOX_IEN]            NUMERIC (22, 4) NULL,
    [SUBJECT_CONTAINS]        VARCHAR (45)    NULL,
    [SENDER]                  VARCHAR (30)    NULL
);

