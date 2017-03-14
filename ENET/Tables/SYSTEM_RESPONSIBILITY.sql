CREATE TABLE [dbo].[SYSTEM_RESPONSIBILITY] (
    [SystemResponsibilityId] INT      IDENTITY (1, 1) NOT NULL,
    [ResponsibilityId]       INT      NULL,
    [SystemNameId]           INT      NULL,
    [CreatedDate]            DATETIME CONSTRAINT [DF_SYSTEM_RESPONSIBILITY_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]              INT      CONSTRAINT [DF_SYSTEM_RESPONSIBILITY_CreatedBy] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_SYSTEM_RESPONSIBILITY] PRIMARY KEY CLUSTERED ([SystemResponsibilityId] ASC)
);

