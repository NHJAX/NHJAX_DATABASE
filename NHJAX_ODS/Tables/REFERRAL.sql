CREATE TABLE [dbo].[REFERRAL] (
    [ReferralId]           BIGINT          IDENTITY (1, 1) NOT NULL,
    [ReferralKey]          NUMERIC (17, 3) NULL,
    [ReferralDate]         DATETIME        NULL,
    [ReasonForReferral]    VARCHAR (5000)  CONSTRAINT [DF_REFERRAL_ReasonForReferral] DEFAULT ('Not Found') NULL,
    [ReferredToProviderId] BIGINT          CONSTRAINT [DF_REFERRAL_ReferredToProviderId] DEFAULT ((0)) NULL,
    [ReferredToLocationId] BIGINT          CONSTRAINT [DF_REFERRAL_ReferredToLocationId] DEFAULT ((0)) NULL,
    [ReferredByProviderId] BIGINT          CONSTRAINT [DF_REFERRAL_ReferredByProviderId] DEFAULT ((0)) NULL,
    [ReferredByLocationId] BIGINT          CONSTRAINT [DF_REFERRAL_ReferredByLocationId] DEFAULT ((0)) NULL,
    [PatientOrderId]       BIGINT          CONSTRAINT [DF_REFERRAL_PatientOrderId] DEFAULT ((0)) NULL,
    [AncillaryProcedureId] BIGINT          CONSTRAINT [DF_REFERRAL_AncillaryProcedureId] DEFAULT ((0)) NULL,
    [CreatedDate]          DATETIME        CONSTRAINT [DF_REFERRAL_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]          DATETIME        CONSTRAINT [DF_REFERRAL_UpdatedDate] DEFAULT (getdate()) NULL,
    [SourceSystemId]       BIGINT          CONSTRAINT [DF_REFERRAL_SourceSystemId] DEFAULT ((2)) NULL,
    [PlaceofTreatmentId]   BIGINT          CONSTRAINT [DF_REFERRAL_PlaceofTreatmentId] DEFAULT ((0)) NULL,
    [ProvisionalDiagnosis] VARCHAR (1000)  NULL,
    [SpecialtyId]          BIGINT          CONSTRAINT [DF_REFERRAL_SpecialtyId] DEFAULT ((0)) NULL,
    [AuthorizationNumber]  DECIMAL (21, 3) NULL,
    [PatientId]            BIGINT          CONSTRAINT [DF_REFERRAL_PatientId] DEFAULT ((0)) NULL,
    [NumberofVisits]       DECIMAL (8, 3)  NULL,
    [ReferralNumber]       VARCHAR (11)    NULL,
    [PriorityId]           BIGINT          CONSTRAINT [DF_REFERRAL_PriorityId] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_REFERRAL] PRIMARY KEY CLUSTERED ([ReferralId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_REFERRAL_ReferralDate]
    ON [dbo].[REFERRAL]([ReferralDate] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_REFERRAL_PatientOrderId]
    ON [dbo].[REFERRAL]([PatientOrderId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_REFERRAL_SourceSystemId]
    ON [dbo].[REFERRAL]([SourceSystemId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_REFERRAL_AuthorizationNumber]
    ON [dbo].[REFERRAL]([AuthorizationNumber] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_REFERRAL_ReferralKey]
    ON [dbo].[REFERRAL]([ReferralKey] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_REFERRAL_ReferredToProviderId]
    ON [dbo].[REFERRAL]([ReferredToProviderId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_REFERRAL_ReferredToLocationId]
    ON [dbo].[REFERRAL]([ReferredToLocationId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_REFERRAL_SpecialtyId]
    ON [dbo].[REFERRAL]([SpecialtyId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_REFERRAL_CreatedDate]
    ON [dbo].[REFERRAL]([CreatedDate] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_REFERRAL_PatientId]
    ON [dbo].[REFERRAL]([PatientId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_REFERRAL_ReferralNumber]
    ON [dbo].[REFERRAL]([ReferralNumber] ASC);

