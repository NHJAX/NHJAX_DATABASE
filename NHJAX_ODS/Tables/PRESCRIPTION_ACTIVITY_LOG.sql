CREATE TABLE [dbo].[PRESCRIPTION_ACTIVITY_LOG] (
    [PrescriptionActivityLogId]  BIGINT          IDENTITY (1, 1) NOT NULL,
    [PrescriptionActivityLogKey] NUMERIC (14, 3) NULL,
    [PrescriptionId]             BIGINT          NULL,
    [ActivityLogDate]            DATETIME        NULL,
    [UserComments]               VARCHAR (100)   NULL,
    [LoggedBy]                   BIGINT          NULL,
    [PharmacySiteId]             BIGINT          NULL,
    [Remarks]                    VARCHAR (100)   NULL,
    [AssociatedFillNumber]       NUMERIC (8, 3)  NULL,
    [ReasonCodeId]               INT             NULL,
    [AuthorizingProviderId]      BIGINT          NULL,
    [CreatedDate]                DATETIME        CONSTRAINT [DF_PRESCRIPTION_ACTIVITY_LOG_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_PRESCRIPTION_ACTIVITY_LOG] PRIMARY KEY CLUSTERED ([PrescriptionActivityLogId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_PRESCRIPTION_ACTIVITY_LOG_PrescriptionKey]
    ON [dbo].[PRESCRIPTION_ACTIVITY_LOG]([PrescriptionActivityLogKey] ASC, [PrescriptionId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PRESCRIPTION_ACTIVITY_LOG_PrescriptionId_PrescriptionActivityLogKey]
    ON [dbo].[PRESCRIPTION_ACTIVITY_LOG]([PrescriptionActivityLogKey] ASC, [PrescriptionId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PRESCRIPTION_ACTIVITY_LOG_ReasonCodeId_ActivityLogDate]
    ON [dbo].[PRESCRIPTION_ACTIVITY_LOG]([ReasonCodeId] ASC, [ActivityLogDate] ASC);

