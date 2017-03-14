CREATE TABLE [dbo].[BUILDING] (
    [BuildingId]   INT          IDENTITY (1, 1) NOT NULL,
    [BuildingDesc] VARCHAR (50) NULL,
    [BaseId]       INT          CONSTRAINT [DF_BUILDING_BaseId] DEFAULT ((0)) NULL,
    [CreatedDate]  DATETIME     CONSTRAINT [DF_BUILDING_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]    INT          CONSTRAINT [DF_BUILDING_CreatedBy] DEFAULT ((0)) NULL,
    [UpdatedDate]  DATETIME     CONSTRAINT [DF_BUILDING_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]    INT          CONSTRAINT [DF_BUILDING_UpdatedBy] DEFAULT ((0)) NULL,
    [Inactive]     BIT          CONSTRAINT [DF_BUILDING_Inactive] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_BUILDING] PRIMARY KEY CLUSTERED ([BuildingId] ASC),
    CONSTRAINT [FK_BUILDING_BASE] FOREIGN KEY ([BaseId]) REFERENCES [dbo].[BASE] ([BaseId])
);

