CREATE TABLE [dbo].[RADIOLOGY_REPORT] (
    [RadiologyReportId]  BIGINT          IDENTITY (1, 1) NOT NULL,
    [RadiologyReportKey] NUMERIC (13, 3) NULL,
    [CreatedDateTime]    DATETIME        NULL,
    [PatientId]          BIGINT          NULL,
    [ResultCategoryId]   BIGINT          NULL,
    [ExamDateTime]       DATETIME        NULL,
    [ReportText]         VARCHAR (8000)  NULL,
    [CreatedDate]        DATETIME        CONSTRAINT [DF_RADIOLOGY_REPORT_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]        DATETIME        CONSTRAINT [DF_RADIOLOGY_REPORT_UpdatedDate] DEFAULT (getdate()) NULL,
    [SourceSystemId]     BIGINT          CONSTRAINT [DF_RADIOLOGY_REPORT_SourceSystemId] DEFAULT ((0)) NULL,
    [VerifyDate]         DATETIME        NULL,
    CONSTRAINT [PK_RADIOLOGY_REPORT] PRIMARY KEY CLUSTERED ([RadiologyReportId] ASC),
    CONSTRAINT [FK_RADIOLOGY_REPORT_PATIENT] FOREIGN KEY ([PatientId]) REFERENCES [dbo].[PATIENT] ([PatientId]),
    CONSTRAINT [FK_RADIOLOGY_REPORT_RESULT_CATEGORY] FOREIGN KEY ([ResultCategoryId]) REFERENCES [dbo].[RESULT_CATEGORY] ([ResultCategoryId])
);


GO
CREATE NONCLUSTERED INDEX [IX_RADIOLOGY_REPORT_RadiologyReportKey]
    ON [dbo].[RADIOLOGY_REPORT]([RadiologyReportKey] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_RADIOLOGY_REPORT_ExamDateTime]
    ON [dbo].[RADIOLOGY_REPORT]([ExamDateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_RADIOLOGY_REPORT_SourceSystemId]
    ON [dbo].[RADIOLOGY_REPORT]([SourceSystemId] ASC);

