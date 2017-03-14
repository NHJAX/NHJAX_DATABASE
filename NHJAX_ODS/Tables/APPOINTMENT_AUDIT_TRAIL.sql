﻿CREATE TABLE [dbo].[APPOINTMENT_AUDIT_TRAIL] (
    [AppointmentAuditTrailId]  BIGINT          IDENTITY (1, 1) NOT NULL,
    [AppointmentAuditTrailKey] NUMERIC (14, 3) NULL,
    [AppointmentStatusId]      BIGINT          NULL,
    [HospitalLocationId]       BIGINT          NULL,
    [MedicalCenterDivisionId]  BIGINT          NULL,
    [PatientEncounterId]       BIGINT          NULL,
    [CHCSUserId]               BIGINT          NULL,
    [CreatedDate]              DATETIME        CONSTRAINT [DF_APPOINTMENT_AUDIT_TRAIL_CreatedDate] DEFAULT (getdate()) NULL,
    [StatusModifierId]         BIGINT          CONSTRAINT [DF_APPOINTMENT_AUDIT_TRAIL_StatusModifierId] DEFAULT (0) NULL,
    CONSTRAINT [PK_APPOINTMENT_AUDIT_TRAIL] PRIMARY KEY CLUSTERED ([AppointmentAuditTrailId] ASC),
    CONSTRAINT [FK_APPOINTMENT_AUDIT_TRAIL_APPOINTMENT_STATUS] FOREIGN KEY ([AppointmentStatusId]) REFERENCES [dbo].[APPOINTMENT_STATUS] ([AppointmentStatusId]),
    CONSTRAINT [FK_APPOINTMENT_AUDIT_TRAIL_CHCS_USER] FOREIGN KEY ([CHCSUserId]) REFERENCES [dbo].[CHCS_USER] ([CHCSUserId]),
    CONSTRAINT [FK_APPOINTMENT_AUDIT_TRAIL_HOSPITAL_LOCATION] FOREIGN KEY ([HospitalLocationId]) REFERENCES [dbo].[HOSPITAL_LOCATION] ([HospitalLocationId]),
    CONSTRAINT [FK_APPOINTMENT_AUDIT_TRAIL_MEDICAL_CENTER_DIVISION] FOREIGN KEY ([MedicalCenterDivisionId]) REFERENCES [dbo].[MEDICAL_CENTER_DIVISION] ([MedicalCenterDivisionId]),
    CONSTRAINT [FK_APPOINTMENT_AUDIT_TRAIL_PATIENT_ENCOUNTER] FOREIGN KEY ([PatientEncounterId]) REFERENCES [dbo].[PATIENT_ENCOUNTER] ([PatientEncounterId]),
    CONSTRAINT [FK_APPOINTMENT_AUDIT_TRAIL_STATUS_MODIFIER] FOREIGN KEY ([StatusModifierId]) REFERENCES [dbo].[STATUS_MODIFIER] ([StatusModifierId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_APPOINTMENT_AUDIT_TRAIL_AppointmentAuditTrailKey]
    ON [dbo].[APPOINTMENT_AUDIT_TRAIL]([AppointmentAuditTrailKey] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_APPOINTMENT_AUDIT_TRAIL_PatientEncounterId]
    ON [dbo].[APPOINTMENT_AUDIT_TRAIL]([PatientEncounterId] ASC);
