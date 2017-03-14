CREATE TABLE [dbo].[REFERRAL_REFUSAL_ARCHIVE] (
    [ReferralRefusalId]  BIGINT         NOT NULL,
    [ReferralRefusalKey] NUMERIC (7, 3) NULL,
    [ReferralId]         BIGINT         NULL,
    [RefusalStatusId]    BIGINT         NULL,
    [RefusalReasonId]    BIGINT         NULL,
    [RefusalDateTime]    DATETIME       NULL,
    [CreatedDate]        DATETIME       NULL,
    [UpdatedDate]        DATETIME       NULL,
    [ArchiveDate]        DATETIME       CONSTRAINT [DF_REFERRAL_REFUSAL_ARCHIVE_ArchiveDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_REFERRAL_REFUSAL_ARCHIVE] PRIMARY KEY CLUSTERED ([ReferralRefusalId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_REFERRAL_REFUSAL_ARCHIVE_ReferralId]
    ON [dbo].[REFERRAL_REFUSAL_ARCHIVE]([ReferralId] ASC) WITH (FILLFACTOR = 100);

