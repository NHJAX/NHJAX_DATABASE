CREATE TABLE [dbo].[BRANCH_OF_SERVICE] (
    [BranchofServiceId]   BIGINT         IDENTITY (1, 1) NOT NULL,
    [BranchofServiceKey]  NUMERIC (8, 3) NULL,
    [BranchofServiceDesc] VARCHAR (36)   NULL,
    [BranchofServiceCode] VARCHAR (3)    NULL,
    [CreatedDate]         DATETIME       CONSTRAINT [DF_BRANCH_OF_SERVICE_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]         DATETIME       CONSTRAINT [DF_BRANCH_OF_SERVICE_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_BRANCH_OF_SERVICE] PRIMARY KEY CLUSTERED ([BranchofServiceId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_BRANCH_OF_SERVICE_KEY]
    ON [dbo].[BRANCH_OF_SERVICE]([BranchofServiceKey] ASC);

