CREATE TABLE [dbo].[APPLICATION_MENU] (
    [MenuId]      INT           IDENTITY (1, 1) NOT NULL,
    [MenuName]    NVARCHAR (50) NOT NULL,
    [CreatedID]   INT           NOT NULL,
    [CreatedDate] DATETIME      NOT NULL,
    [UpdatedID]   INT           NULL,
    [UpdatedDate] DATETIME      NULL,
    CONSTRAINT [PK_APPLICATION_MENU] PRIMARY KEY CLUSTERED ([MenuId] ASC)
);

