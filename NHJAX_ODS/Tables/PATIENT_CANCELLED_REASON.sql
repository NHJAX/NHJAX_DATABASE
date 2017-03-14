CREATE TABLE [dbo].[PATIENT_CANCELLED_REASON] (
    [PatientCancelledReasonId]   INT          NULL,
    [PatientCancelledReasonDesc] VARCHAR (50) NULL,
    [CreatedDate]                DATETIME     CONSTRAINT [DF_PATIENT_CANCELLED_REASON_CreatedDate] DEFAULT (getdate()) NULL
);

