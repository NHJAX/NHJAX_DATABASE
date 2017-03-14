CREATE TABLE [dbo].[REFERRAL_REVIEW_STATUS_ARCHIVE] (
    [ReferralReviewStatusId]  BIGINT         NOT NULL,
    [ReferralId]              BIGINT         NULL,
    [ReviewStatusId]          BIGINT         NULL,
    [ReferralReviewDate]      DATETIME       NULL,
    [ReferralReviewStatusKey] NUMERIC (8, 3) NULL,
    [ReviewComment]           VARCHAR (4000) NULL,
    [CreatedDate]             DATETIME       NULL,
    [ReviewerId]              BIGINT         NULL,
    [UpdatedDate]             DATETIME       NULL,
    [ArchiveDate]             DATETIME       CONSTRAINT [DF_REFERRAL_REVIEW_STATUS_ARCHIVE_ArchiveDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_REFERRAL_REVIEW_STATUS_ARCHIVE] PRIMARY KEY CLUSTERED ([ReferralReviewStatusId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_REFERRAL_REVIEW_STATUS_ARCHIVE_ReferralId]
    ON [dbo].[REFERRAL_REVIEW_STATUS_ARCHIVE]([ReferralId] ASC) WITH (FILLFACTOR = 100);

