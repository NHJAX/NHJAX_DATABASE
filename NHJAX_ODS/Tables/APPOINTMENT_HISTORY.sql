CREATE TABLE [dbo].[APPOINTMENT_HISTORY] (
    [AppointmentHistoryId] INT      IDENTITY (1, 1) NOT NULL,
    [AppointmentDate]      DATE     NOT NULL,
    [AppointmentDateTime]  DATETIME NOT NULL,
    [AppointmentStatusId]  INT      NOT NULL,
    [LocationId]           INT      NULL,
    [ProviderId]           INT      NULL,
    [CreatedDateTime]      DATETIME CONSTRAINT [DF_APPOINTMENT_HISTORY_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_APPOINTMENT_HISTORY] PRIMARY KEY CLUSTERED ([AppointmentHistoryId] ASC)
);

