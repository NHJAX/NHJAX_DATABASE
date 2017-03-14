CREATE TABLE [dbo].[REGISTRATION_TYPE] (
    [RegistrationTypeId]   BIGINT       NOT NULL,
    [RegistrationTypeDesc] VARCHAR (50) NULL,
    [CreatedDate]          DATETIME     CONSTRAINT [DF_REGISTRATION_TYPE_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_REGISTRATION_TYPE] PRIMARY KEY CLUSTERED ([RegistrationTypeId] ASC)
);

