CREATE TABLE [dbo].[REVIEW_STATUS] (
    [ReviewStatusId]      BIGINT         IDENTITY (1, 1) NOT NULL,
    [ReviewStatusKey]     NUMERIC (8, 3) NULL,
    [ReviewStatusDesc]    VARCHAR (30)   NULL,
    [ReviewStatusDisplay] VARCHAR (24)   NULL,
    [CreatedDate]         DATETIME       CONSTRAINT [DF_REVIEW_STATUS_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]         DATETIME       CONSTRAINT [DF_REVIEW_STATUS_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_REVIEW_STATUS] PRIMARY KEY CLUSTERED ([ReviewStatusId] ASC)
);

