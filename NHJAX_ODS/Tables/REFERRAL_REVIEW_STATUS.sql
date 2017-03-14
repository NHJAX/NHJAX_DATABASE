CREATE TABLE [dbo].[REFERRAL_REVIEW_STATUS] (
    [ReferralReviewStatusId]  BIGINT         IDENTITY (1, 1) NOT NULL,
    [ReferralId]              BIGINT         NULL,
    [ReviewStatusId]          BIGINT         NULL,
    [ReferralReviewDate]      DATETIME       NULL,
    [ReferralReviewStatusKey] NUMERIC (8, 3) NULL,
    [ReviewComment]           VARCHAR (4000) NULL,
    [CreatedDate]             DATETIME       CONSTRAINT [DF_REFERRAL_REVIEW_STATUS_CreatedDate] DEFAULT (getdate()) NULL,
    [ReviewerId]              BIGINT         NULL,
    [UpdatedDate]             DATETIME       CONSTRAINT [DF_REFERRAL_REVIEW_STATUS_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_REFERRAL_REVIEW_STATUS] PRIMARY KEY CLUSTERED ([ReferralReviewStatusId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_REFERRAL_REVIEW_STATUS_ReferralId_ReviewStatusId]
    ON [dbo].[REFERRAL_REVIEW_STATUS]([ReferralId] ASC, [ReviewStatusId] ASC, [ReferralReviewStatusKey] ASC);

