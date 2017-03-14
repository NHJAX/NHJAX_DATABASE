﻿CREATE TABLE [dbo].[PRESCRIPTION_STATUS] (
    [PreStatusId]   INT          IDENTITY (0, 1) NOT NULL,
    [PreStatusDesc] VARCHAR (50) NULL,
    [CreatedDate]   DATETIME     CONSTRAINT [DF_PRESRIPTION_STATUS_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_PRESCRIPTION_STATUS] PRIMARY KEY CLUSTERED ([PreStatusId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_PRESCRIPTION_STATUS_PreStatusDesc]
    ON [dbo].[PRESCRIPTION_STATUS]([PreStatusDesc] ASC);

