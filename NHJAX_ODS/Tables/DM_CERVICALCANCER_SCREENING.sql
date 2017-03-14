CREATE TABLE [dbo].[DM_CERVICALCANCER_SCREENING] (
    [DM_CervicalCancerScreeningId] BIGINT   IDENTITY (1, 1) NOT NULL,
    [PatientId]                    BIGINT   NOT NULL,
    [CreatedDate]                  DATETIME CONSTRAINT [DF_DM_CERVICALCANCER_SCREENING_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]                  DATETIME CONSTRAINT [DF_DM_CERVICALCANCER_SCREENING_UpdatedDate] DEFAULT (getdate()) NULL
);

