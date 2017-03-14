CREATE TABLE [dbo].[EDUCATION_LEVEL] (
    [EducationLevelId]   INT          NOT NULL,
    [EducationLevelDesc] VARCHAR (50) NULL,
    [CreatedDate]        DATETIME     CONSTRAINT [DF_EDUCATION_LEVEL_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_EDUCATION_LEVEL] PRIMARY KEY CLUSTERED ([EducationLevelId] ASC)
);

