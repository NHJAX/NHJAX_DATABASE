CREATE TABLE [dbo].[REPORT] (
    [ReportId]    INT          NOT NULL,
    [ReportDesc]  VARCHAR (50) NULL,
    [ReportName]  VARCHAR (50) NULL,
    [Inactive]    BIT          CONSTRAINT [DF_REPORT_Inactive] DEFAULT ((0)) NULL,
    [CreatedDate] DATETIME     CONSTRAINT [DF_REPORT_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_REPORT] PRIMARY KEY CLUSTERED ([ReportId] ASC)
);

