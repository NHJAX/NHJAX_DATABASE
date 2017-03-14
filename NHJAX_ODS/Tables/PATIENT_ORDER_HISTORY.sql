CREATE TABLE [dbo].[PATIENT_ORDER_HISTORY] (
    [PatientOrderHistoryId] BIGINT   IDENTITY (1, 1) NOT NULL,
    [OrderId]               BIGINT   NULL,
    [OrderStatusId]         BIGINT   NULL,
    [CreatedDate]           DATETIME CONSTRAINT [DF_PATIENT_ORDER_HISTORY_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_PATIENT_ORDER_HISTORY] PRIMARY KEY CLUSTERED ([PatientOrderHistoryId] ASC)
);

