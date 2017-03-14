CREATE TABLE [dbo].[MAILING_ADDRESS] (
    [MailingAddressId] BIGINT        IDENTITY (1, 1) NOT NULL,
    [Address1]         VARCHAR (100) NULL,
    [Address2]         VARCHAR (100) NULL,
    [City]             VARCHAR (50)  NULL,
    [State]            VARCHAR (2)   NULL,
    [Zip]              VARCHAR (10)  NULL,
    [AddressTypeId]    INT           CONSTRAINT [DF_MAILING_ADDRESS_AddressTypeId] DEFAULT ((0)) NULL,
    [CreatedDate]      DATETIME      CONSTRAINT [DF_MAILING_ADDRESS_CreatedDate] DEFAULT (getdate()) NULL,
    [Inactive]         BIT           CONSTRAINT [DF_MAILING_ADDRESS_Inactive] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_MAILING_ADDRESS] PRIMARY KEY CLUSTERED ([MailingAddressId] ASC)
);

