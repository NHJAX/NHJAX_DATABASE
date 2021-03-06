﻿CREATE TABLE [dbo].[DEERS_TRANSMISSION_QUEUE] (
    [KEY_SITE]                     NUMERIC (5)     NULL,
    [KEY_DEERS_TRANSMISSION_QUEUE] NUMERIC (13, 3) NULL,
    [TIME_OF_REQUEST]              DATETIME        NULL,
    [TRANSMISSION_TYPE]            VARCHAR (5)     NULL,
    [PATIENT_IEN]                  NUMERIC (21, 3) NULL,
    [SOURCE]                       VARCHAR (5)     NULL,
    [USER_IEN]                     NUMERIC (21, 3) NULL,
    [SERVER]                       NUMERIC (8, 3)  NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ind_DEERS_TRANSMISSION_QUEUE]
    ON [dbo].[DEERS_TRANSMISSION_QUEUE]([KEY_SITE] ASC, [KEY_DEERS_TRANSMISSION_QUEUE] ASC);

