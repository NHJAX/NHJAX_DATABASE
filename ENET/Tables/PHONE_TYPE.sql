CREATE TABLE [dbo].[PHONE_TYPE] (
    [PhoneTypeId]   INT          NOT NULL,
    [PhoneTypeDesc] VARCHAR (50) NULL,
    [CreatedDate]   DATETIME     CONSTRAINT [DF_PHONE_TYPE_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_PHONE_TYPE] PRIMARY KEY CLUSTERED ([PhoneTypeId] ASC)
);

