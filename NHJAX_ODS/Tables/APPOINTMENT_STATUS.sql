﻿CREATE TABLE [dbo].[APPOINTMENT_STATUS] (
    [AppointmentStatusId]   BIGINT         IDENTITY (1, 1) NOT NULL,
    [AppointmentStatusKey]  NUMERIC (8, 3) NULL,
    [AppointmentStatusDesc] VARCHAR (30)   NULL,
    [CreatedDate]           DATETIME       CONSTRAINT [DF_APPOINTMENT_STATUS_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]           DATETIME       CONSTRAINT [DF_APPOINTMENT_STATUS_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_APPOINTMENT_STATUS] PRIMARY KEY CLUSTERED ([AppointmentStatusId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_APPOINTMENT_STATUS_KEY]
    ON [dbo].[APPOINTMENT_STATUS]([AppointmentStatusKey] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_APPOINTMENT_STATUS_DESC]
    ON [dbo].[APPOINTMENT_STATUS]([AppointmentStatusDesc] ASC, [AppointmentStatusId] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_APPT_STATUS_APPTSTATUSID]
    ON [dbo].[APPOINTMENT_STATUS]([AppointmentStatusId] ASC, [AppointmentStatusDesc] ASC);

