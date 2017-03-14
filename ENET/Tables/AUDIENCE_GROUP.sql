CREATE TABLE [dbo].[AUDIENCE_GROUP] (
    [AudienceCategoryId]   INT      NOT NULL,
    [AudienceId]           BIGINT   NOT NULL,
    [GroupId]              INT      NOT NULL,
    [CreatedDate]          DATETIME CONSTRAINT [DF_AUDIENCE_GROUP_CreatedDate] DEFAULT (getdate()) NULL,
    [FlowStep]             INT      NOT NULL,
    [EMailNotification]    BIT      CONSTRAINT [DF_AUDIENCE_GROUP_EMailNotification] DEFAULT ((0)) NULL,
    [SendToMember]         BIT      CONSTRAINT [DF_AUDIENCE_GROUP_SendToMember] DEFAULT ((0)) NULL,
    [CheckOutNotification] BIT      CONSTRAINT [DF_AUDIENCE_GROUP_CheckOutNotification] DEFAULT ((0)) NULL,
    [SecurityNotification] BIT      CONSTRAINT [DF_AUDIENCE_GROUP_SecurityNotification] DEFAULT ((0)) NULL,
    [IsLeaveAlternate]     BIT      CONSTRAINT [DF_AUDIENCE_GROUP_IsLeaveAlternate] DEFAULT ((0)) NULL,
    [IsLeaveEdit]          BIT      CONSTRAINT [DF_AUDIENCE_GROUP_IsLeaveEdit] DEFAULT ((0)) NULL,
    [IsRestrictedGroup]    BIT      CONSTRAINT [DF_AUDIENCE_GROUP_IsRestrictedGroup] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_AUDIENCE_GROUP_1] PRIMARY KEY CLUSTERED ([AudienceCategoryId] ASC, [AudienceId] ASC, [GroupId] ASC),
    CONSTRAINT [FK_AUDIENCE_GROUP_AUDIENCE] FOREIGN KEY ([AudienceId]) REFERENCES [dbo].[AUDIENCE] ([AudienceId]),
    CONSTRAINT [FK_AUDIENCE_GROUP_SECURITY_GROUP] FOREIGN KEY ([GroupId]) REFERENCES [dbo].[SECURITY_GROUP] ([SecurityGroupId])
);

