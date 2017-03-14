CREATE TABLE [dbo].[sessINV_PROJECT] (
    [SessionKey]  INT      IDENTITY (1, 1) NOT NULL,
    [CreatedBy]   INT      NULL,
    [CreatedDate] DATETIME CONSTRAINT [DF_sessINV_PROJECT_CreatedDate] DEFAULT (getdate()) NULL,
    [ProjectId]   INT      NULL,
    CONSTRAINT [PK_sessINV_PROJECT] PRIMARY KEY CLUSTERED ([SessionKey] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_sessINV_PROJECT_CreatedBy]
    ON [dbo].[sessINV_PROJECT]([CreatedBy] ASC);

