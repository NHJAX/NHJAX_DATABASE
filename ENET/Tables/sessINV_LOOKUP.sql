CREATE TABLE [dbo].[sessINV_LOOKUP] (
    [SessionKey]  INT          IDENTITY (1, 1) NOT NULL,
    [LookupId]    INT          NULL,
    [LookupValue] VARCHAR (50) NULL,
    [CreatedBy]   INT          NULL,
    [CreatedDate] DATETIME     CONSTRAINT [DF_sessINV_LOOKUP_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_sessINV_LOOKUP] PRIMARY KEY CLUSTERED ([SessionKey] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_sessINV_LOOKUP_CreatedBy]
    ON [dbo].[sessINV_LOOKUP]([CreatedBy] ASC);

