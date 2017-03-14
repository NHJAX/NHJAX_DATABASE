CREATE TABLE [dbo].[ORDER_STATUS_TYPE] (
    [OrderStatusTypeId]   INT          NOT NULL,
    [OrderStatusTypeDesc] VARCHAR (50) NULL,
    [CreatedDate]         DATETIME     CONSTRAINT [DF_ORDER_STATUS_TYPE_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_ORDER_STATUS_TYPE] PRIMARY KEY CLUSTERED ([OrderStatusTypeId] ASC)
);

