CREATE TABLE [dbo].[DISPOSITION] (
    [DispositionId]   INT          NOT NULL,
    [DispositionDesc] VARCHAR (50) NULL,
    [CreatedDate]     DATETIME     CONSTRAINT [DF_DISPOSITION_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]       INT          CONSTRAINT [DF_DISPOSITION_CreatedBy] DEFAULT ((0)) NULL,
    [UpdatedDate]     DATETIME     CONSTRAINT [DF_DISPOSITION_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]       INT          CONSTRAINT [DF_DISPOSITION_UpdatedBy] DEFAULT ((0)) NULL,
    [ViewLevelId]     INT          CONSTRAINT [DF_DISPOSITION_ViewLevelId] DEFAULT ((2)) NULL,
    CONSTRAINT [PK_DISPOSITION] PRIMARY KEY CLUSTERED ([DispositionId] ASC),
    CONSTRAINT [FK_DISPOSITION_VIEW_LEVEL] FOREIGN KEY ([ViewLevelId]) REFERENCES [dbo].[VIEW_LEVEL] ([ViewLevelId])
);

