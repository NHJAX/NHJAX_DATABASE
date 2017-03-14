CREATE TABLE [dbo].[PROBLEM_TYPE] (
    [ProblemTypeId]   INT          IDENTITY (1, 1) NOT NULL,
    [ProblemTypeDesc] VARCHAR (50) NULL,
    [CreatedDate]     DATETIME     CONSTRAINT [DF_PROBLEM_TYPE_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]       INT          CONSTRAINT [DF_PROBLEM_TYPE_CreatedBy] DEFAULT ((0)) NULL,
    [Inactive]        BIT          CONSTRAINT [DF_PROBLEM_TYPE_Inactive] DEFAULT ((0)) NOT NULL,
    [UpdatedDate]     DATETIME     CONSTRAINT [DF_PROBLEM_TYPE_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]       INT          CONSTRAINT [DF_PROBLEM_TYPE_UpdatedBy] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_PROBLEM_TYPE] PRIMARY KEY CLUSTERED ([ProblemTypeId] ASC)
);

