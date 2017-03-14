CREATE TABLE [dbo].[PRESCRIPTION] (
    [PrescriptionId]       BIGINT          IDENTITY (1, 1) NOT NULL,
    [PrescriptionKey]      NUMERIC (14, 3) NULL,
    [RXNumber]             VARCHAR (20)    NULL,
    [PatientId]            BIGINT          NULL,
    [ProviderId]           BIGINT          CONSTRAINT [DF_PRESCRIPTION_ProviderId] DEFAULT ((0)) NULL,
    [DrugId]               BIGINT          NULL,
    [Quantity]             NUMERIC (15, 5) NULL,
    [DaysSupply]           NUMERIC (10, 3) NULL,
    [Refills]              NUMERIC (8, 3)  NULL,
    [PreStatusId]          INT             CONSTRAINT [DF_PRESCRIPTION_PreStatusId] DEFAULT ((0)) NULL,
    [RefillsRemaining]     NUMERIC (8, 3)  NULL,
    [LastFillDate]         DATETIME        NULL,
    [FillExpiration]       DATETIME        NULL,
    [ExpirationDate]       DATETIME        NULL,
    [OrderDateTime]        DATETIME        NULL,
    [OrderId]              BIGINT          NULL,
    [Comments]             VARCHAR (80)    NULL,
    [Sig]                  VARCHAR (220)   NULL,
    [Sig1]                 VARCHAR (28)    NULL,
    [Sig2]                 VARCHAR (28)    NULL,
    [Sig3]                 VARCHAR (29)    NULL,
    [UnitCost]             MONEY           NULL,
    [CreatedDate]          DATETIME        CONSTRAINT [DF_PRESCRIPTION_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]          DATETIME        CONSTRAINT [DF_PRESCRIPTION_UpdatedDate] DEFAULT (getdate()) NULL,
    [AcceptedPrescriber]   VARCHAR (26)    NULL,
    [SourceSystemId]       BIGINT          NULL,
    [PharmacyId]           BIGINT          CONSTRAINT [DF_PRESCRIPTION_PharmacyId] DEFAULT ((0)) NULL,
    [PrescriptionEditedId] BIGINT          CONSTRAINT [con_PRESCRIPTIONEDITEDID] DEFAULT ((0)) NULL,
    [LoggedBy]             BIGINT          CONSTRAINT [DF_PRESCRIPTION_LoggedBy] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_PRESCRIPTION] PRIMARY KEY CLUSTERED ([PrescriptionId] ASC),
    CONSTRAINT [FK_PRESCRIPTION_PHARMACY] FOREIGN KEY ([PharmacyId]) REFERENCES [dbo].[PHARMACY] ([PharmacyId]),
    CONSTRAINT [FK_PRESCRIPTION_PRESCRIPTION_STATUS] FOREIGN KEY ([PreStatusId]) REFERENCES [dbo].[PRESCRIPTION_STATUS] ([PreStatusId]),
    CONSTRAINT [FK_PRESCRIPTION_PROVIDER] FOREIGN KEY ([ProviderId]) REFERENCES [dbo].[PROVIDER] ([ProviderId])
);


GO
CREATE NONCLUSTERED INDEX [IX_PRESCRIPTION_KEY]
    ON [dbo].[PRESCRIPTION]([PrescriptionKey] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PRESCRIPTION_PatientId_OrderDateTime]
    ON [dbo].[PRESCRIPTION]([PatientId] ASC, [OrderDateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PRESCRIPTION_PatientId_DrugId_SourceSystemId]
    ON [dbo].[PRESCRIPTION]([PatientId] ASC, [DrugId] ASC, [SourceSystemId] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_PRESCRIPTION_SourceSystemId]
    ON [dbo].[PRESCRIPTION]([SourceSystemId] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_PRESCRIPTION_PatientId]
    ON [dbo].[PRESCRIPTION]([PatientId] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_PRESCRIPTION_LastFillDate]
    ON [dbo].[PRESCRIPTION]([LastFillDate] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_PRESCRIPTION_PresId,RXNumber,Patid,SSId,DaysSupply]
    ON [dbo].[PRESCRIPTION]([PrescriptionId] ASC, [RXNumber] ASC, [PatientId] ASC, [SourceSystemId] ASC, [DaysSupply] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PRESCRIPTION_PrescriptionKey]
    ON [dbo].[PRESCRIPTION]([PrescriptionKey] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PRESCRIPTION_ProviderId_CreatedDate]
    ON [dbo].[PRESCRIPTION]([ProviderId] ASC, [CreatedDate] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PRESCRIPTION_RXNumber,DrugId]
    ON [dbo].[PRESCRIPTION]([RXNumber] ASC, [DrugId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PRESCRIPTION_PrescriptionId_LastFillDate]
    ON [dbo].[PRESCRIPTION]([PrescriptionId] ASC, [LastFillDate] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PRESCRIPTION_PharmacyId]
    ON [dbo].[PRESCRIPTION]([PharmacyId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PRESCRIPTION_PreStatusId]
    ON [dbo].[PRESCRIPTION]([PreStatusId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PRESCRIPTION_OrderId]
    ON [dbo].[PRESCRIPTION]([OrderId] ASC);

