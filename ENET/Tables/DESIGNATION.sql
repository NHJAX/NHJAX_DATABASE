CREATE TABLE [dbo].[DESIGNATION] (
    [DesignationId]   INT          NOT NULL,
    [DesignationDesc] VARCHAR (30) NULL,
    [CreatedDate]     DATETIME     CONSTRAINT [DF_CORPS_CreatedDate] DEFAULT (getdate()) NULL,
    [SortOrder]       INT          NULL,
    [EMailAbbrev]     VARCHAR (4)  NULL,
    CONSTRAINT [PK_DESIGNATION] PRIMARY KEY CLUSTERED ([DesignationId] ASC)
);

