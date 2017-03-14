CREATE TABLE [dbo].[sessINV_MODEL] (
    [SessionKey]  INT      IDENTITY (1, 1) NOT NULL,
    [CreatedBy]   INT      NULL,
    [CreatedDate] DATETIME CONSTRAINT [DF_sessINV_MODEL_CreatedDate] DEFAULT (getdate()) NULL,
    [ModelId]     INT      NULL,
    CONSTRAINT [PK_sessINV_MODEL] PRIMARY KEY CLUSTERED ([SessionKey] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_sessINV_MODEL_CreatedBy]
    ON [dbo].[sessINV_MODEL]([CreatedBy] ASC);

