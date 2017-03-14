﻿CREATE TABLE [dbo].[APPOINTMENT_TYPE] (
    [KEY_SITE]             NUMERIC (5)     NULL,
    [KEY_APPOINTMENT_TYPE] NUMERIC (10, 3) NULL,
    [NAME]                 VARCHAR (6)     NULL,
    [DESCRIPTION]          VARCHAR (30)    NULL,
    [STATUS]               VARCHAR (30)    NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ind_APPOINTMENT_TYPE]
    ON [dbo].[APPOINTMENT_TYPE]([KEY_SITE] ASC, [KEY_APPOINTMENT_TYPE] ASC);

