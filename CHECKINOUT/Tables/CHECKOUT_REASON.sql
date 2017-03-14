CREATE TABLE [dbo].[CHECKOUT_REASON] (
    [CheckoutReasonId]   INT          NOT NULL,
    [CheckoutReasonDesc] VARCHAR (50) NULL,
    [Inactive]           BIT          CONSTRAINT [DF_CHECKOUT_REASON_Inactive] DEFAULT ((0)) NULL,
    [CreatedDate]        DATETIME     CONSTRAINT [DF_CHECKOUT_REASON_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_CHECKOUT_REASON] PRIMARY KEY CLUSTERED ([CheckoutReasonId] ASC)
);

