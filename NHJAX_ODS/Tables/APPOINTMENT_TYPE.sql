CREATE TABLE [dbo].[APPOINTMENT_TYPE] (
    [AppointmentTypeId]   BIGINT          IDENTITY (1, 1) NOT NULL,
    [AppointmentTypeKey]  NUMERIC (10, 3) NULL,
    [AppointmentTypeCode] VARCHAR (6)     NULL,
    [AppointmentTypeDesc] VARCHAR (30)    NULL,
    [CreatedDate]         DATETIME        CONSTRAINT [DF_APPOINTMENT_TYPE_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]         DATETIME        CONSTRAINT [DF_APPOINTMENT_TYPE_UpdatedDate] DEFAULT (getdate()) NULL,
    [Inactive]            BIT             CONSTRAINT [DF_APPOINTMENT_TYPE_Inactive] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_APPOINTMENT_TYPE] PRIMARY KEY CLUSTERED ([AppointmentTypeId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_APPOINTMENT_TYPE_KEY]
    ON [dbo].[APPOINTMENT_TYPE]([AppointmentTypeKey] ASC);

