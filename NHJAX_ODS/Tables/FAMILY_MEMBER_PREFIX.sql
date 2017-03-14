CREATE TABLE [dbo].[FAMILY_MEMBER_PREFIX] (
    [FamilyMemberPrefixId]     BIGINT         IDENTITY (1, 1) NOT NULL,
    [FamilyMemberPrefixKey]    NUMERIC (8, 3) NULL,
    [FamilyMemberPrefixNumber] NUMERIC (9, 3) NULL,
    [FamilyMemberPrefixCode]   VARCHAR (30)   NULL,
    [FamilyMemberPrefixDesc]   VARCHAR (50)   NULL,
    [CreatedDate]              DATETIME       CONSTRAINT [DF_FAMILY_MEMBER_PREFIX_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]              DATETIME       CONSTRAINT [DF_FAMILY_MEMBER_PREFIX_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_FAMILY_MEMBER_PREFIX] PRIMARY KEY CLUSTERED ([FamilyMemberPrefixId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_FAMILY_MEMBER_PREFIX_KEY]
    ON [dbo].[FAMILY_MEMBER_PREFIX]([FamilyMemberPrefixKey] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_FAMILY_MEMBER_PREFIX_Code]
    ON [dbo].[FAMILY_MEMBER_PREFIX]([FamilyMemberPrefixCode] ASC);

