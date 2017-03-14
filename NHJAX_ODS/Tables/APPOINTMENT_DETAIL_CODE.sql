CREATE TABLE [dbo].[APPOINTMENT_DETAIL_CODE] (
    [AppointmentDetailId]   BIGINT         IDENTITY (1, 1) NOT NULL,
    [AppointmentDetailKey]  NUMERIC (9, 3) NULL,
    [AppointmentDetailCode] VARCHAR (8)    NULL,
    [AppointmentDetailDesc] VARCHAR (75)   NULL,
    [Inactive]              BIT            CONSTRAINT [DF_APPOINTMENT_DETAIL_CODE_Inactive] DEFAULT (0) NULL,
    [CreatedDate]           DATETIME       CONSTRAINT [DF_APPOINTMENT_DETAIL_CODE_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]           DATETIME       CONSTRAINT [DF_APPOINTMENT_DETAIL_CODE_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_APPOINTMENT_DETAIL_CODE] PRIMARY KEY CLUSTERED ([AppointmentDetailId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_APPOINTMENT_DETAIL_CODE_AppointmentDetailKey]
    ON [dbo].[APPOINTMENT_DETAIL_CODE]([AppointmentDetailKey] ASC);

