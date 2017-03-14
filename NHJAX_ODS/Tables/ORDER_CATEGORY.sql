CREATE TABLE [dbo].[ORDER_CATEGORY] (
    [OrderCategoryId]   INT          IDENTITY (1, 1) NOT NULL,
    [OrderCategoryDesc] VARCHAR (50) NULL,
    [CreatedDate]       DATETIME     CONSTRAINT [DF_ORDER_CATEGORY_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_ORDER_CATEGORY] PRIMARY KEY CLUSTERED ([OrderCategoryId] ASC)
);

