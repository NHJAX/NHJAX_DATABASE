CREATE TABLE [dbo].[AUDIENCE] (
    [AudienceId]         BIGINT        IDENTITY (1, 1) NOT NULL,
    [AudienceDesc]       VARCHAR (50)  NULL,
    [DisplayName]        VARCHAR (50)  NULL,
    [OrgChartCode]       VARCHAR (20)  NULL,
    [ReportsUnder]       BIGINT        NOT NULL,
    [IsSubGroup]         BIT           CONSTRAINT [DF_ORG_CHART_IsSubOrg] DEFAULT ((0)) NULL,
    [CreatedDate]        DATETIME      CONSTRAINT [DF_ORG_CHART_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]        DATETIME      CONSTRAINT [DF_ORG_CHART_UpdatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]          INT           CONSTRAINT [DF_AUDIENCE_CreatedBy] DEFAULT ((0)) NULL,
    [UpdatedBy]          INT           CONSTRAINT [DF_AUDIENCE_UpdatedBy] DEFAULT ((0)) NULL,
    [AudienceCategoryId] INT           NULL,
    [AudiencePhone]      VARCHAR (15)  NULL,
    [AudienceFax]        VARCHAR (50)  NULL,
    [AudiencePager]      VARCHAR (15)  NULL,
    [Inactive]           BIT           CONSTRAINT [DF_ORG_CHART_Inactive] DEFAULT ((0)) NULL,
    [OldDepartmentId]    INT           NULL,
    [SecurityGroupId]    INT           CONSTRAINT [DF_AUDIENCE_SecurityGroupId] DEFAULT ((0)) NULL,
    [BaseId]             INT           CONSTRAINT [DF_AUDIENCE_BaseId] DEFAULT ((0)) NULL,
    [IsVisible]          BIT           CONSTRAINT [DF_AUDIENCE_IsVisible] DEFAULT ((1)) NULL,
    [IsSpecialSoftware]  BIT           CONSTRAINT [DF_AUDIENCE_IsSpecialSoftware] DEFAULT ((0)) NULL,
    [IsCustomPR]         BIT           CONSTRAINT [DF_AUDIENCE_IsCustomPR] DEFAULT ((0)) NULL,
    [SortOrder]          INT           NULL,
    [HasAlternates]      BIT           CONSTRAINT [DF_AUDIENCE_HasAlternates] DEFAULT ((0)) NULL,
    [OrganizationName]   VARCHAR (100) NULL,
    [OrganizationCode]   VARCHAR (6)   NULL,
    [UIC]                VARCHAR (5)   NULL,
    [DoNotDisplay]       BIT           CONSTRAINT [DF_AUDIENCE_DoNotDisplay] DEFAULT ((0)) NULL,
    [GroupName]          VARCHAR (100) NULL,
    [DirectorName]       VARCHAR (100) NULL,
    CONSTRAINT [PK_ORG_CHART] PRIMARY KEY CLUSTERED ([AudienceId] ASC),
    CONSTRAINT [FK_AUDIENCE_AUDIENCE_CATEGORY] FOREIGN KEY ([AudienceCategoryId]) REFERENCES [dbo].[AUDIENCE_CATEGORY] ([AudienceCategoryId])
);


GO
CREATE NONCLUSTERED INDEX [IX_AUDIENCE_AudienceCategoryId_OldDepartmentId]
    ON [dbo].[AUDIENCE]([AudienceCategoryId] ASC, [OldDepartmentId] ASC);

