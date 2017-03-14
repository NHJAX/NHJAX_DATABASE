CREATE TABLE [dbo].[RANK] (
    [RankId]        INT             NOT NULL,
    [RankAbbrev]    VARCHAR (4)     NULL,
    [CreatedDate]   DATETIME        CONSTRAINT [DF_RANK_CreatedDate] DEFAULT (getdate()) NULL,
    [DesignationId] INT             NULL,
    [RankDesc]      VARCHAR (50)    NULL,
    [SortOrder]     NUMERIC (10, 2) CONSTRAINT [DF_RANK_SortOrder] DEFAULT ((0)) NULL,
    [Inactive]      BIT             CONSTRAINT [DF_RANK_Inactive] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_RANK] PRIMARY KEY CLUSTERED ([RankId] ASC)
);

