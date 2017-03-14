CREATE TABLE [dbo].[ER_DISPOSITION] (
    [ERDispositionId]   INT          NOT NULL,
    [ERDispositionDesc] VARCHAR (50) NULL,
    [CreatedDate]       DATETIME     CONSTRAINT [DF_ER_DISPOSITION_CreatedDate] DEFAULT (getdate()) NULL,
    [ERDispositionCode] VARCHAR (2)  NULL,
    CONSTRAINT [PK_ER_DISPOSITION] PRIMARY KEY CLUSTERED ([ERDispositionId] ASC)
);

