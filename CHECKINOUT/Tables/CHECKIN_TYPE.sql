﻿CREATE TABLE [dbo].[CHECKIN_TYPE] (
    [CheckInTypeId]   INT          NOT NULL,
    [CheckInTypeDesc] VARCHAR (50) NULL,
    CONSTRAINT [PK_CHECKIN_TYPE] PRIMARY KEY CLUSTERED ([CheckInTypeId] ASC)
);

