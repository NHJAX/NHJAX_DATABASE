CREATE TABLE [dbo].[AUDIENCE_CATEGORY] (
    [AudienceCategoryId]   INT          NOT NULL,
    [AudienceCategoryDesc] VARCHAR (50) NULL,
    [CreatedDate]          DATETIME     CONSTRAINT [DF_ORG_CATEGORY_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_ORG_CATEGORY] PRIMARY KEY CLUSTERED ([AudienceCategoryId] ASC)
);

