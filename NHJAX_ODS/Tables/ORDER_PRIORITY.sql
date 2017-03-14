CREATE TABLE [dbo].[ORDER_PRIORITY] (
    [OrderPriorityId]   BIGINT          NOT NULL,
    [OrderPriorityKey]  NUMERIC (10, 4) NULL,
    [OrderPriorityCode] NUMERIC (7, 3)  NULL,
    [OrderPriorityDesc] VARCHAR (30)    NULL,
    [CreatedDate]       DATETIME        CONSTRAINT [DF_ORDER_PRIORITY_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]       DATETIME        CONSTRAINT [DF_ORDER_PRIORITY_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_ORDER_PRIORITY] PRIMARY KEY CLUSTERED ([OrderPriorityId] ASC)
);

