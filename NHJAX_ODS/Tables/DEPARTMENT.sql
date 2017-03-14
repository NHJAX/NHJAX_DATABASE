CREATE TABLE [dbo].[DEPARTMENT] (
    [DepartmentId]     BIGINT         IDENTITY (0, 1) NOT NULL,
    [DepartmentKey]    NUMERIC (9, 3) NULL,
    [DepartmentDesc]   VARCHAR (34)   NULL,
    [DepartmentAbbrev] VARCHAR (5)    NULL,
    [CreatedDate]      DATETIME       CONSTRAINT [DF_DEPARTMENT_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]      DATETIME       CONSTRAINT [DF_DEPARTMENT_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_DEPARTMENT] PRIMARY KEY CLUSTERED ([DepartmentId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_DEPARTMENT_KEY]
    ON [dbo].[DEPARTMENT]([DepartmentKey] ASC);

