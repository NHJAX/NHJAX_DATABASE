CREATE TABLE [dbo].[LAB_TEST] (
    [LabTestid]     BIGINT          IDENTITY (1, 1) NOT NULL,
    [LabTestKey]    NUMERIC (10, 3) NULL,
    [LabTestDesc]   VARCHAR (30)    NULL,
    [LabTestTypeId] BIGINT          NULL,
    [UnitCost]      MONEY           CONSTRAINT [DF_LAB_TEST_UnitCost] DEFAULT (0) NULL,
    [CreatedDate]   DATETIME        CONSTRAINT [DF_LAB_TEST_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]   DATETIME        CONSTRAINT [DF_LAB_TEST_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_LAB_TEST] PRIMARY KEY CLUSTERED ([LabTestid] ASC),
    CONSTRAINT [FK_LAB_TEST_LAB_TEST_TYPE] FOREIGN KEY ([LabTestTypeId]) REFERENCES [dbo].[LAB_TEST_TYPE] ([LabTestTypeId])
);


GO
CREATE NONCLUSTERED INDEX [IX_LAB_TEST_KEY]
    ON [dbo].[LAB_TEST]([LabTestKey] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_LAB_TEST_LabTestDesc]
    ON [dbo].[LAB_TEST]([LabTestDesc] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_LAB_TEST_LabTestId,labTestDesc]
    ON [dbo].[LAB_TEST]([LabTestid] ASC, [LabTestDesc] ASC);

