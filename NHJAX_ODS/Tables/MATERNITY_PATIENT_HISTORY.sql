CREATE TABLE [dbo].[MATERNITY_PATIENT_HISTORY] (
    [MaternityPatientId] BIGINT         NOT NULL,
    [PatientId]          BIGINT         NULL,
    [EDC]                DATE           NULL,
    [MaternityStatusId]  INT            NULL,
    [Notes]              VARCHAR (8000) NULL,
    [MaternityTeamId]    INT            NULL,
    [CreatedDate]        DATETIME       NULL,
    [UpdatedDate]        DATETIME       NULL,
    [CreatedBy]          INT            NULL,
    [UpdatedBy]          INT            NULL,
    [FPProviderId]       INT            NULL,
    [HistoryDate]        DATETIME       CONSTRAINT [DF_MATERNITY_PATIENT_HISTORY_HistoryDate] DEFAULT (getdate()) NULL
);


GO
CREATE CLUSTERED INDEX [IX_MATERNITY_PATIENT_HISTORY_MaternityPatientId]
    ON [dbo].[MATERNITY_PATIENT_HISTORY]([MaternityPatientId] ASC);

