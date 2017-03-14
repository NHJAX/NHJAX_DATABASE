CREATE TABLE [dbo].[VIEW_LEVEL] (
    [ViewLevelId]   INT          NOT NULL,
    [ViewLevelDesc] VARCHAR (50) NULL,
    [CreatedDate]   DATETIME     CONSTRAINT [DF_VIEW_LEVEL_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_VIEW_LEVEL] PRIMARY KEY CLUSTERED ([ViewLevelId] ASC)
);

