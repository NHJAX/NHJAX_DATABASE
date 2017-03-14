CREATE TABLE [dbo].[MESSAGE] (
    [KEY_SITE]            NUMERIC (5)     NULL,
    [KEY_MESSAGE]         NUMERIC (14, 3) NULL,
    [NUMBER_]             NUMERIC (15, 3) NULL,
    [SUBJECT]             VARCHAR (65)    NULL,
    [USER_POINTER_IEN]    NUMERIC (22, 4) NULL,
    [SENDER_POINTER_IEN]  VARCHAR (32)    NULL,
    [TYPE_]               VARCHAR (30)    NULL,
    [DATE_ENTERED]        DATETIME        NULL,
    [INCOMING_MESSAGE_ID] VARCHAR (80)    NULL,
    [TEXT]                TEXT            NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ind_MESSAGE]
    ON [dbo].[MESSAGE]([KEY_SITE] ASC, [KEY_MESSAGE] ASC);

