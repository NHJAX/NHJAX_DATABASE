CREATE TABLE [dbo].[REPORT] (
    [ReportId]         INT          IDENTITY (1, 1) NOT NULL,
    [ReportName]       VARCHAR (50) NULL,
    [ReportDesc]       VARCHAR (50) NULL,
    [ReportCategoryId] INT          NULL,
    [SecurityGroupId]  BIGINT       NULL,
    CONSTRAINT [PK_REPORT] PRIMARY KEY CLUSTERED ([ReportId] ASC)
);

