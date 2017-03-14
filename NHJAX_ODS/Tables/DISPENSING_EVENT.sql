CREATE TABLE [dbo].[DISPENSING_EVENT] (
    [DispensingEventId]   BIGINT          IDENTITY (1, 1) NOT NULL,
    [PrescriptionId]      BIGINT          NOT NULL,
    [RXNumber]            VARCHAR (20)    NULL,
    [DrugDesc]            VARCHAR (41)    NOT NULL,
    [DaysSupply]          NUMERIC (10, 3) NULL,
    [MaxFillDate]         DATETIME        NOT NULL,
    [PharmacyDesc]        VARCHAR (50)    NOT NULL,
    [SourceSystemId]      BIGINT          NOT NULL,
    [DiseaseManagementId] BIGINT          NOT NULL,
    [PatientId]           BIGINT          NOT NULL,
    [CreatedDate]         DATETIME        CONSTRAINT [DF_DISPENSING_EVENT_CreatedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_DISPENSING_EVENT] PRIMARY KEY CLUSTERED ([DispensingEventId] ASC),
    CONSTRAINT [FK_DISPENSING_EVENT_DISEASE_MANAGEMENT] FOREIGN KEY ([DiseaseManagementId]) REFERENCES [dbo].[DISEASE_MANAGEMENT] ([DiseaseManagementId]),
    CONSTRAINT [FK_DISPENSING_EVENT_PRESCRIPTION] FOREIGN KEY ([PrescriptionId]) REFERENCES [dbo].[PRESCRIPTION] ([PrescriptionId])
);

