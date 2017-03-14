CREATE TABLE [dbo].[RADIOLOGY_EXAM] (
    [RadiologyExamId]        BIGINT          IDENTITY (1, 1) NOT NULL,
    [RadiologyExamKey]       DECIMAL (15, 3) NULL,
    [ExamDateTime]           DATETIME        NULL,
    [ExamStatusId]           BIGINT          CONSTRAINT [DF_RADIOLOGY_EXAM_ExamStatusId] DEFAULT ((0)) NULL,
    [ExamNumber]             VARCHAR (8)     NULL,
    [PatientId]              BIGINT          NULL,
    [RadiologyId]            BIGINT          NULL,
    [OrderId]                BIGINT          NULL,
    [OrderKey]               NUMERIC (21, 3) NULL,
    [HospitalLocationId]     BIGINT          NULL,
    [ProviderId]             BIGINT          NULL,
    [UnitCost]               MONEY           NULL,
    [CreatedDate]            DATETIME        CONSTRAINT [DF_RADIOLOGY_EXAM_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]            DATETIME        CONSTRAINT [DF_RADIOLOGY_EXAM_UpdatedDate] DEFAULT (getdate()) NULL,
    [RadiologyReportId]      BIGINT          NULL,
    [SourceSystemId]         BIGINT          CONSTRAINT [DF_RADIOLOGY_EXAM_SourceSystemId] DEFAULT ((0)) NULL,
    [TotalExposures]         NUMERIC (9, 3)  NULL,
    [WasBariumUsed]          BIT             NULL,
    [IntravascularContrast]  BIT             NULL,
    [ArrivalDateTime]        DATETIME        NULL,
    [DepartureDateTime]      VARCHAR (16)    NULL,
    [Portable]               VARCHAR (16)    NULL,
    [PatientMobilityStatus]  VARCHAR (30)    NULL,
    [StartDateTime]          VARCHAR (16)    NULL,
    [EndDateTime]            VARCHAR (16)    NULL,
    [ImagingTypeId]          BIGINT          CONSTRAINT [DF_RADIOLOGY_EXAM_ImageTypeId] DEFAULT ((0)) NULL,
    [PerformingTechnicianId] BIGINT          NULL,
    CONSTRAINT [PK_RADIOLOGY_EXAM] PRIMARY KEY CLUSTERED ([RadiologyExamId] ASC),
    CONSTRAINT [FK_RADIOLOGY_EXAM_EXAM_STATUS] FOREIGN KEY ([ExamStatusId]) REFERENCES [dbo].[EXAM_STATUS] ([ExamStatusId]),
    CONSTRAINT [FK_RADIOLOGY_EXAM_PATIENT_ORDER] FOREIGN KEY ([OrderId]) REFERENCES [dbo].[PATIENT_ORDER] ([OrderId]),
    CONSTRAINT [FK_RADIOLOGY_EXAM_RADIOLOGY] FOREIGN KEY ([RadiologyId]) REFERENCES [dbo].[RADIOLOGY] ([RadiologyId])
);


GO
CREATE NONCLUSTERED INDEX [IX_RADIOLOGY_EXAM_EXAMDATETIME]
    ON [dbo].[RADIOLOGY_EXAM]([PatientId] ASC, [ExamDateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_RADIOLOGY_EXAM_PATIENTID_RADID_EXAMDATETIME]
    ON [dbo].[RADIOLOGY_EXAM]([ExamDateTime] ASC, [PatientId] ASC, [RadiologyId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_RADIOLOGY_EXAM_SourceSystemId]
    ON [dbo].[RADIOLOGY_EXAM]([SourceSystemId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_RADIOLOGY_EXAM_RadiologyExamKey]
    ON [dbo].[RADIOLOGY_EXAM]([RadiologyExamKey] ASC);

