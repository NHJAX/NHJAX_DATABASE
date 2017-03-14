CREATE TABLE [dbo].[MENU_ITEMS] (
    [MenuItemId]     INT            IDENTITY (112, 1) NOT NULL,
    [ParentItemId]   INT            NOT NULL,
    [MenuId]         INT            NOT NULL,
    [MenuItemText]   NVARCHAR (50)  NOT NULL,
    [MenuItemURL]    NVARCHAR (250) NULL,
    [DisplayOrder]   INT            NULL,
    [ExternalLink]   BIT            NULL,
    [TargetLocation] NVARCHAR (50)  NULL,
    [AudienceId]     INT            NULL,
    [CreatedDate]    DATETIME       NOT NULL,
    [CreatedBy]      INT            NOT NULL,
    [UpdatedDate]    DATETIME       NULL,
    [UpdatedBy]      INT            NULL,
    CONSTRAINT [PK_MENU_ITEM] PRIMARY KEY CLUSTERED ([MenuItemId] ASC) WITH (FILLFACTOR = 100)
);

