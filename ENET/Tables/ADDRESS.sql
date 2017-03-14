CREATE TABLE [dbo].[ADDRESS] (
    [AddressId]     BIGINT        IDENTITY (1, 1) NOT NULL,
    [AddressTypeId] INT           NULL,
    [Address1]      VARCHAR (100) NULL,
    [Address2]      VARCHAR (100) NULL,
    [City]          VARCHAR (50)  NULL,
    [State]         VARCHAR (2)   NULL,
    [Zip]           VARCHAR (10)  NULL,
    [CreatedDate]   DATETIME      CONSTRAINT [DF_ADDRESS_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]   DATETIME      CONSTRAINT [DF_ADDRESS_UpdatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]     INT           CONSTRAINT [DF_ADDRESS_CreatedBy] DEFAULT ((0)) NULL,
    [UpdatedBy]     INT           CONSTRAINT [DF_ADDRESS_UpdatedBy] DEFAULT ((0)) NULL,
    [Inactive]      BIT           CONSTRAINT [DF_ADDRESS_Inactive] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_ADDRESS] PRIMARY KEY CLUSTERED ([AddressId] ASC)
);

