CREATE TABLE [dbo].[SERVER_RESPONSIBILITY] (
    [ServerResponsibilityId] INT      IDENTITY (1, 1) NOT NULL,
    [ResponsibilityId]       INT      NULL,
    [AssetId]                INT      NULL,
    [CreatedDate]            DATETIME CONSTRAINT [DF_SERVER_RESPONSIBILITY_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]              INT      CONSTRAINT [DF_SERVER_RESPONSIBILITY_CreatedBy] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_SERVER_RESPONSIBILITY] PRIMARY KEY CLUSTERED ([ServerResponsibilityId] ASC)
);

