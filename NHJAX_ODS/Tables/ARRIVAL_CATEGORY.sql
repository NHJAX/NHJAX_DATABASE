CREATE TABLE [dbo].[ARRIVAL_CATEGORY] (
    [ArrivalCategoryId]   BIGINT       IDENTITY (1, 1) NOT NULL,
    [ArrivalCategoryDesc] VARCHAR (30) NULL,
    [CreatedDate]         DATETIME     CONSTRAINT [DF_ARRIVAL_CATEGORY_CreatedDate] DEFAULT (getdate()) NULL,
    [ArrivalCategoryCode] VARCHAR (1)  NULL,
    CONSTRAINT [PK_ARRIVAL_CATEGORY] PRIMARY KEY CLUSTERED ([ArrivalCategoryId] ASC)
);

