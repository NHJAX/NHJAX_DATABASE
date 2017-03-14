CREATE TABLE [dbo].[sessINV_POC] (
    [SessionKey]  INT      IDENTITY (1, 1) NOT NULL,
    [CreatedBy]   INT      NULL,
    [CreatedDate] DATETIME CONSTRAINT [DF_sessINV_POC_CreatedDate] DEFAULT (getdate()) NULL,
    [POCId]       INT      NULL,
    CONSTRAINT [PK_sessINV_POC] PRIMARY KEY CLUSTERED ([SessionKey] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_sessINV_POC_CreatedBy]
    ON [dbo].[sessINV_POC]([CreatedBy] ASC);

