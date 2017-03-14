CREATE TABLE [dbo].[AUDIENCE_STEP] (
    [AudienceStepId] BIGINT   IDENTITY (1, 1) NOT NULL,
    [AudienceId]     BIGINT   NULL,
    [CheckInStepId]  BIGINT   NULL,
    [CreatedDate]    DATETIME CONSTRAINT [DF_AUDIENCE_STEP_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_AUDIENCE_STEP] PRIMARY KEY CLUSTERED ([AudienceStepId] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_AUDIENCE_STEP_AudienceId_CheckInStepId]
    ON [dbo].[AUDIENCE_STEP]([AudienceId] ASC, [CheckInStepId] ASC);

