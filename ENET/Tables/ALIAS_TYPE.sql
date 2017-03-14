CREATE TABLE [dbo].[ALIAS_TYPE] (
    [AliasTypeId]   INT          NOT NULL,
    [AliasTypeDesc] VARCHAR (50) NULL,
    [CreatedDate]   DATETIME     CONSTRAINT [DF_ALIAS_TYPE_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_ALIAS_TYPE] PRIMARY KEY CLUSTERED ([AliasTypeId] ASC)
);

