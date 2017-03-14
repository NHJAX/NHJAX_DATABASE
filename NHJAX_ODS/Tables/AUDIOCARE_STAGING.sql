CREATE TABLE [dbo].[AUDIOCARE_STAGING] (
    [FullName]           NVARCHAR (255) NULL,
    [FamilyMemberPrefix] NVARCHAR (255) NULL,
    [SponsorSSN]         NVARCHAR (255) NULL,
    [PhoneNumber]        NVARCHAR (255) NULL,
    [DOB]                NVARCHAR (255) NULL,
    [CreatedDate]        DATETIME       CONSTRAINT [DF_AUDIOCARE_STAGING_CreatedDate] DEFAULT (getdate()) NULL
);

