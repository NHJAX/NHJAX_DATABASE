CREATE TABLE [dbo].[SYSTEM_TYPE] (
    [SystemId]        INT            IDENTITY (1, 1) NOT NULL,
    [SystemDesc]      NVARCHAR (50)  NULL,
    [Inactive]        BIT            CONSTRAINT [DF_SYSTEM_Inactive] DEFAULT ((0)) NOT NULL,
    [CreatedDate]     DATETIME       CONSTRAINT [DF_SYSTEM_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]       INT            CONSTRAINT [DF_SYSTEM_CreatedBy] DEFAULT ((0)) NULL,
    [UpdatedDate]     DATETIME       CONSTRAINT [DF_SYSTEM_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]       INT            CONSTRAINT [DF_SYSTEM_UpdatedBy] DEFAULT ((0)) NULL,
    [IsBurndown]      BIT            CONSTRAINT [DF_SYSTEM_TYPE_IsBurndown] DEFAULT ((0)) NULL,
    [IsManagedSystem] BIT            CONSTRAINT [DF_SYSTEM_TYPE_IsManagedSystem] DEFAULT ((0)) NULL,
    [IsProcessOnly]   BIT            CONSTRAINT [DF_SYSTEM_TYPE_IsProcessOnly] DEFAULT ((0)) NULL,
    [DoNotDisplay]    BIT            CONSTRAINT [DF_SYSTEM_TYPE_DoNotDisplay] DEFAULT ((0)) NULL,
    [Notes]           NVARCHAR (MAX) NULL,
    [SystemOwnerId]   INT            CONSTRAINT [DF_SYSTEM_TYPE_OwnerId] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_SYSTEM] PRIMARY KEY CLUSTERED ([SystemId] ASC)
);

