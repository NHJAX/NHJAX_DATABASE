CREATE TABLE [dbo].[PRESCRIPTION_EDITED] (
    [PrescriptionEditedId] BIGINT       IDENTITY (1, 1) NOT NULL,
    [EditedDesc]           VARCHAR (30) NULL,
    [CreatedDate]          DATETIME     CONSTRAINT [DF_PRESCRIPTION_EDITED_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_PRESCRIPTION_EDITED] PRIMARY KEY CLUSTERED ([PrescriptionEditedId] ASC)
);

