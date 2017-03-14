CREATE TABLE [dbo].[PRIMARY_CARE_MANAGER] (
    [PCMId]                        BIGINT       IDENTITY (1, 1) NOT NULL,
    [PatientID]                    BIGINT       NULL,
    [ProviderId]                   BIGINT       NULL,
    [PCMProjectedEndDate_20090326] VARCHAR (15) NULL,
    [DmisId]                       BIGINT       NULL,
    [EnrollmentHistoryNumber]      INT          NULL,
    [PCMHistoryNumber]             INT          NULL,
    [PCMEnrollmentDate]            DATETIME     NULL,
    [CreatedDate]                  DATETIME     CONSTRAINT [DF_AAA_PRIMARY_CARE_MANAGER_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]                  DATETIME     CONSTRAINT [DF_AAA_PRIMARY_CARE_MANAGER_UpdatedDate] DEFAULT (getdate()) NULL,
    [HospitalLocationId]           BIGINT       NULL,
    [IsUpdated]                    BIT          CONSTRAINT [DF_AAA_PRIMARY_CARE_MANAGER_IsUpdated] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_AAA_PRIMARY_CARE_MANAGER] PRIMARY KEY CLUSTERED ([PCMId] ASC),
    CONSTRAINT [FK_AAA_PRIMARY_CARE_MANAGER_PATIENT] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[PATIENT] ([PatientId]),
    CONSTRAINT [FK_AAA_PRIMARY_CARE_MANAGER_PROVIDER] FOREIGN KEY ([ProviderId]) REFERENCES [dbo].[PROVIDER] ([ProviderId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_PRIMARY_CARE_MANAGER_PatientId]
    ON [dbo].[PRIMARY_CARE_MANAGER]([PatientID] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'getdate()', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PRIMARY_CARE_MANAGER', @level2type = N'COLUMN', @level2name = N'UpdatedDate';

