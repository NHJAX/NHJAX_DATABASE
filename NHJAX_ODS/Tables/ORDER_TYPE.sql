﻿CREATE TABLE [dbo].[ORDER_TYPE] (
    [OrderTypeId]   BIGINT         IDENTITY (1, 1) NOT NULL,
    [OrderTypeKey]  NUMERIC (8, 3) NULL,
    [OrderTypeDesc] VARCHAR (4)    NULL,
    [CreatedDate]   DATETIME       CONSTRAINT [DF_ORDER_TYPE_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]   DATETIME       CONSTRAINT [DF_ORDER_TYPE_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_ORDER_TYPE] PRIMARY KEY CLUSTERED ([OrderTypeId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_ORDER_TYPE_KEY]
    ON [dbo].[ORDER_TYPE]([OrderTypeKey] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_ORDER_TYPE_OrderTypeDesc]
    ON [dbo].[ORDER_TYPE]([OrderTypeDesc] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);

