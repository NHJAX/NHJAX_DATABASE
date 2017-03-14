CREATE TABLE [dbo].[REFERRAL_LOG] (
    [ReferralLogId]   BIGINT         IDENTITY (1, 1) NOT NULL,
    [ReferralLogDesc] VARCHAR (1000) NULL,
    [CreatedDate]     DATETIME       CONSTRAINT [DF_REFERRAL_LOG_CreatedDate] DEFAULT (getdate()) NULL,
    [UserId]          INT            CONSTRAINT [DF_REFERRAL_LOG_UserId] DEFAULT ((0)) NULL,
    [LogTypeId]       INT            CONSTRAINT [DF_REFERRAL_LOG_LogTypeId] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_REFERRAL_LOG] PRIMARY KEY CLUSTERED ([ReferralLogId] ASC)
);

