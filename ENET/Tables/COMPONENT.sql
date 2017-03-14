CREATE TABLE [dbo].[COMPONENT] (
    [ComponentId]   INT            NOT NULL,
    [ComponentDesc] NVARCHAR (50)  NOT NULL,
    [CreatedDate]   DATETIME       CONSTRAINT [DF_COMPONENT_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [ComponentName] NVARCHAR (255) NULL,
    CONSTRAINT [PK_COMPONENT] PRIMARY KEY CLUSTERED ([ComponentId] ASC)
);

