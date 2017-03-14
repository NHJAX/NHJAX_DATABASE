CREATE TABLE [dbo].[REFERRAL_REFUSAL] (
    [ReferralRefusalId]  BIGINT         IDENTITY (1, 1) NOT NULL,
    [ReferralRefusalKey] NUMERIC (7, 3) NULL,
    [ReferralId]         BIGINT         NULL,
    [RefusalStatusId]    BIGINT         NULL,
    [RefusalReasonId]    BIGINT         NULL,
    [RefusalDateTime]    DATETIME       NULL,
    [CreatedDate]        DATETIME       CONSTRAINT [DF_REFERRAL_REFUSAL_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]        DATETIME       CONSTRAINT [DF_REFERRAL_REFUSAL_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_REFERRAL_REFUSAL] PRIMARY KEY CLUSTERED ([ReferralRefusalId] ASC),
    CONSTRAINT [FK_REFERRAL_REFUSAL_REFERRAL] FOREIGN KEY ([ReferralId]) REFERENCES [dbo].[REFERRAL] ([ReferralId]),
    CONSTRAINT [FK_REFERRAL_REFUSAL_REFUSAL_REASON] FOREIGN KEY ([RefusalReasonId]) REFERENCES [dbo].[REFUSAL_REASON] ([RefusalReasonId]),
    CONSTRAINT [FK_REFERRAL_REFUSAL_REFUSAL_STATUS] FOREIGN KEY ([RefusalStatusId]) REFERENCES [dbo].[REFUSAL_STATUS] ([RefusalStatusId])
);


GO
CREATE NONCLUSTERED INDEX [IX_REFERRAL_REFUSAL_ReferralRefusalKey_ReferralId]
    ON [dbo].[REFERRAL_REFUSAL]([ReferralRefusalKey] ASC, [ReferralId] ASC);

