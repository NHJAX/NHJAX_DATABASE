CREATE TABLE [dbo].[PRESCRIPTION_ACTIVITY_LOG_REASON] (
    [PrescriptionReasonId] INT            IDENTITY (1, 1) NOT NULL,
    [ReasonCodeKey]        NUMERIC (9, 3) NULL,
    [ReasonDesc]           VARCHAR (20)   NULL,
    [CreatedDate]          DATETIME       CONSTRAINT [DF_PRESCRIPTION_ACTIVITY_LOG_REASON_CreatedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_PRESCRIPTION_ACTIVITY_LOG_REASON] PRIMARY KEY CLUSTERED ([PrescriptionReasonId] ASC)
);

