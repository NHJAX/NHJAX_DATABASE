CREATE TABLE [dbo].[RESULT_CATEGORY] (
    [ResultCategoryId]     BIGINT          NOT NULL,
    [ResultCategoryKey]    NUMERIC (21, 3) NULL,
    [ResultCategoryNumber] NUMERIC (9, 3)  NULL,
    [DiagnosticCode]       VARCHAR (40)    NULL,
    [ResultCategoryDesc]   VARCHAR (80)    NULL,
    [CreatedDate]          DATETIME        CONSTRAINT [DF_RESULT_CATEGORY_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]          DATETIME        CONSTRAINT [DF_RESULT_CATEGORY_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_RESULT_CATEGORY] PRIMARY KEY CLUSTERED ([ResultCategoryId] ASC)
);

