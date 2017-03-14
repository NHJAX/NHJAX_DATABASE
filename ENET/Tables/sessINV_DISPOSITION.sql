CREATE TABLE [dbo].[sessINV_DISPOSITION] (
    [SessionKey]    INT      IDENTITY (1, 1) NOT NULL,
    [CreatedBy]     INT      NULL,
    [CreatedDate]   DATETIME CONSTRAINT [DF_sessINV_DISPOSITION_CreatedDate] DEFAULT (getdate()) NULL,
    [DispositionId] INT      NULL,
    CONSTRAINT [PK_sessINV_DISPOSITION] PRIMARY KEY CLUSTERED ([SessionKey] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_sessINV_DISPOSITION_CreatedBy]
    ON [dbo].[sessINV_DISPOSITION]([CreatedBy] ASC);

