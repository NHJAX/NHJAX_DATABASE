CREATE TABLE [dbo].[APPOINTMENT_SLOT_STATUS] (
    [AppointmentSlotStatusId]   BIGINT       IDENTITY (0, 1) NOT NULL,
    [AppointmentSlotStatusDesc] VARCHAR (30) NULL,
    [CreatedDate]               DATETIME     CONSTRAINT [DF_APPOINTMENT_SLOT_STATUS_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_APPOINTMENT_SLOT_STATUS] PRIMARY KEY CLUSTERED ([AppointmentSlotStatusId] ASC)
);

