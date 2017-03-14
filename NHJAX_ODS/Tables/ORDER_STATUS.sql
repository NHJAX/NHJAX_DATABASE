CREATE TABLE [dbo].[ORDER_STATUS] (
    [OrderStatusId]     BIGINT       IDENTITY (1, 1) NOT NULL,
    [OrderStatusDesc]   VARCHAR (50) NULL,
    [CreatedDate]       DATETIME     CONSTRAINT [DF_ORDER_STATUS_CreatedDate] DEFAULT (getdate()) NULL,
    [OrderStatusTypeId] INT          CONSTRAINT [DF_ORDER_STATUS_OrderStatusTypeId] DEFAULT ((3)) NULL,
    CONSTRAINT [PK_ORDER_STATUS] PRIMARY KEY CLUSTERED ([OrderStatusId] ASC)
);

