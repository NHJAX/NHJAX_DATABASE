CREATE TABLE [dbo].[ADDRESS_TYPE] (
    [AddressTypeId]   INT          NOT NULL,
    [AddressTypeDesc] VARCHAR (50) NULL,
    [CreatedDate]     DATETIME     CONSTRAINT [DF_ADDRESS_TYPE_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_ADDRESS_TYPE] PRIMARY KEY CLUSTERED ([AddressTypeId] ASC)
);

