CREATE TABLE [dbo].[APPOINTMENT_SLOT] (
    [AppointmentSlotId]          BIGINT          IDENTITY (1, 1) NOT NULL,
    [SchedulableEntityKey]       NUMERIC (11, 3) NULL,
    [AppointmentSlotKey]         NUMERIC (14, 3) NULL,
    [AppointmentSlotDateTimeKey] NUMERIC (22, 7) NULL,
    [AppointmentSlotDateTime]    DATETIME        NULL,
    [AppointmentSlotStatusId]    BIGINT          NULL,
    [HospitalLocationId]         BIGINT          NULL,
    [ProviderId]                 BIGINT          NULL,
    [AppointmentTypeId]          BIGINT          NULL,
    [CreatedDate]                DATETIME        CONSTRAINT [DF_APPOINTMENT_SLOT_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]                DATETIME        CONSTRAINT [DF_APPOINTMENT_SLOT_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_APPOINTMENT_SLOT] PRIMARY KEY CLUSTERED ([AppointmentSlotId] ASC),
    CONSTRAINT [FK_APPOINTMENT_SLOT_APPOINTMENT_SLOT_STATUS] FOREIGN KEY ([AppointmentSlotStatusId]) REFERENCES [dbo].[APPOINTMENT_SLOT_STATUS] ([AppointmentSlotStatusId]),
    CONSTRAINT [FK_APPOINTMENT_SLOT_HOSPITAL_LOCATION] FOREIGN KEY ([HospitalLocationId]) REFERENCES [dbo].[HOSPITAL_LOCATION] ([HospitalLocationId]),
    CONSTRAINT [FK_APPOINTMENT_SLOT_PROVIDER] FOREIGN KEY ([ProviderId]) REFERENCES [dbo].[PROVIDER] ([ProviderId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_APPOINTMENT_SLOT_SchedulableEntityKey_AppointmentSlotKey_AppointmentSlotDateTimeKey]
    ON [dbo].[APPOINTMENT_SLOT]([SchedulableEntityKey] ASC, [AppointmentSlotKey] ASC, [AppointmentSlotDateTimeKey] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_APPOINTMENT_SLOT_AppointmentSlotDateTime]
    ON [dbo].[APPOINTMENT_SLOT]([AppointmentSlotDateTime] ASC);

