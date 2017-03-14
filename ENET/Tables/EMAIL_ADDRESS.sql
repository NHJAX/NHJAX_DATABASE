CREATE TABLE [dbo].[EMAIL_ADDRESS] (
    [EMailAddressId] BIGINT        IDENTITY (1, 1) NOT NULL,
    [AddressTypeId]  INT           CONSTRAINT [DF_EMAIL_ADDRESS_EMailTypeId] DEFAULT ((0)) NULL,
    [EMailAddress]   VARCHAR (100) NULL,
    [CreatedDate]    DATETIME      CONSTRAINT [DF_EMAIL_ADDRESS_CreatedDate] DEFAULT (getdate()) NULL,
    [Inactive]       BIT           CONSTRAINT [DF_EMAIL_ADDRESS_Inactive] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_EMAIL_ADDRESS] PRIMARY KEY CLUSTERED ([EMailAddressId] ASC)
);

