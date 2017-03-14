CREATE TABLE [dbo].[SECURITY_LEVEL] (
    [SecurityLevelId]   INT           IDENTITY (0, 1) NOT NULL,
    [SecurityLevel]     VARCHAR (100) NULL,
    [SecurityGroupId]   INT           NULL,
    [CreatedBy]         INT           CONSTRAINT [DF_SECURITY_LEVEL_CreatedBy] DEFAULT ((0)) NULL,
    [CreatedDate]       DATETIME      CONSTRAINT [DF_SECURITY_LEVEL_CreatedDate] DEFAULT (getdate()) NULL,
    [SecurityLevelDesc] VARCHAR (50)  NULL,
    [UpdatedBy]         INT           CONSTRAINT [DF_SECURITY_LEVEL_UpdatedBy] DEFAULT ((0)) NULL,
    [UpdatedDate]       DATETIME      CONSTRAINT [DF_SECURITY_LEVEL_UpdatedDate] DEFAULT (getdate()) NULL,
    [Inactive]          BIT           CONSTRAINT [DF_SECURITY_LEVEL_Inactive] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_SECURITY_LEVEL] PRIMARY KEY CLUSTERED ([SecurityLevelId] ASC),
    CONSTRAINT [FK_SECURITY_LEVEL_SECURITY_GROUP] FOREIGN KEY ([SecurityGroupId]) REFERENCES [dbo].[SECURITY_GROUP] ([SecurityGroupId])
);

