CREATE TABLE [dbo].[CHECKOUT_STATUS] (
    [CheckOutStatusId]   INT          NOT NULL,
    [CheckOutStatusDesc] VARCHAR (50) NULL,
    [CreatedDate]        DATETIME     CONSTRAINT [DF_CHECKOUT_STATUS_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_CHECKOUT_STATUS] PRIMARY KEY CLUSTERED ([CheckOutStatusId] ASC)
);

