CREATE TABLE [dbo].[TEST_TRANSACTION] (
    [TestTransactionId] INT          IDENTITY (1, 1) NOT NULL,
    [TestTableId]       BIGINT       NULL,
    [TestDesc]          VARCHAR (50) NULL,
    CONSTRAINT [PK_TEST_TRANSACTION] PRIMARY KEY CLUSTERED ([TestTransactionId] ASC),
    CONSTRAINT [FK_TEST_TRANSACTION_TEST_TABLE] FOREIGN KEY ([TestTableId]) REFERENCES [dbo].[TEST_TABLE] ([TestPrimaryKey])
);

