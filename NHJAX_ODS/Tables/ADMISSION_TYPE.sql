CREATE TABLE [dbo].[ADMISSION_TYPE] (
    [AdmissionTypeId]   BIGINT         IDENTITY (1, 1) NOT NULL,
    [AdmissionTypeKey]  NUMERIC (8, 3) NULL,
    [AdmissionTypeDesc] VARCHAR (62)   NULL,
    [AdmissionTypeCode] VARCHAR (1)    NULL,
    [CreatedDate]       DATETIME       CONSTRAINT [DF_ADMISSION_TYPE_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]       DATETIME       CONSTRAINT [DF_ADMISSION_TYPE_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_ADMISSION_TYPE] PRIMARY KEY CLUSTERED ([AdmissionTypeId] ASC)
);

