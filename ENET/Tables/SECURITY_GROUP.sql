CREATE TABLE [dbo].[SECURITY_GROUP] (
    [SecurityGroupId]   INT            IDENTITY (0, 1) NOT NULL,
    [SecurityGroupDesc] NVARCHAR (256) NULL,
    [CreatedDate]       DATETIME       CONSTRAINT [DF_SECURITY_GROUP_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]         INT            CONSTRAINT [DF_SECURITY_GROUP_CreatedBy] DEFAULT ((0)) NULL,
    [UpdatedDate]       DATETIME       CONSTRAINT [DF_SECURITY_GROUP_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]         INT            CONSTRAINT [DF_SECURITY_GROUP_UpdatedBy] DEFAULT ((0)) NULL,
    [Inactive]          BIT            CONSTRAINT [DF_SECURITY_GROUP_Inactive] DEFAULT ((0)) NULL,
    [HasAlternates]     BIT            CONSTRAINT [DF_SECURITY_GROUP_HasAlternates] DEFAULT ((0)) NULL,
    [ReturnPage]        VARCHAR (150)  NULL,
    CONSTRAINT [PK_SECURITY_GROUP] PRIMARY KEY CLUSTERED ([SecurityGroupId] ASC)
);

