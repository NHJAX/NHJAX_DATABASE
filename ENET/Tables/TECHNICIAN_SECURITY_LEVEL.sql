CREATE TABLE [dbo].[TECHNICIAN_SECURITY_LEVEL] (
    [TechnicianSecurityLevelId] INT              IDENTITY (1, 1) NOT NULL,
    [UserId]                    INT              NULL,
    [SecurityLevelId]           INT              NULL,
    [SecurityGroupId]           INT              NULL,
    [ReadOnly]                  BIT              CONSTRAINT [DF_TECHNICIAN_SECURITY_LEVEL_ReadOnly] DEFAULT ((0)) NULL,
    [CreatedDate]               DATETIME         CONSTRAINT [DF_TECHNICIAN_SECURITY_LEVEL_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]                 INT              CONSTRAINT [DF_TECHNICIAN_SECURITY_LEVEL_CreatedBy] DEFAULT ((0)) NULL,
    [RoleId]                    UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_TECHNICIAN_SECURITY_LEVEL] PRIMARY KEY CLUSTERED ([TechnicianSecurityLevelId] ASC),
    CONSTRAINT [FK_TECHNICIAN_SECURITY_LEVEL_aspnet_Roles] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[aspnet_Roles] ([RoleId]),
    CONSTRAINT [FK_TECHNICIAN_SECURITY_LEVEL_SECURITY_GROUP] FOREIGN KEY ([SecurityGroupId]) REFERENCES [dbo].[SECURITY_GROUP] ([SecurityGroupId]),
    CONSTRAINT [FK_TECHNICIAN_SECURITY_LEVEL_TECHNICIAN] FOREIGN KEY ([UserId]) REFERENCES [dbo].[TECHNICIAN] ([UserId])
);

