CREATE TABLE [dbo].[PRESCRIPTION_ACTION] (
    [PrescriptionActionId]   BIGINT       IDENTITY (0, 1) NOT NULL,
    [PrescriptionActionDesc] VARCHAR (50) NULL,
    [CreatedDate]            DATETIME     CONSTRAINT [DF_PRESCRIPTION_ACTION_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]            DATETIME     CONSTRAINT [DF_PRESCRIPTION_ACTION_UpdatedDate] DEFAULT (getdate()) NULL,
    [PrescriptionActionKey]  INT          NULL,
    CONSTRAINT [PK_PRESCRIPTION_ACTION] PRIMARY KEY CLUSTERED ([PrescriptionActionId] ASC)
);

