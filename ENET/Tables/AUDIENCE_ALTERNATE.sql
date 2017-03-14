CREATE TABLE [dbo].[AUDIENCE_ALTERNATE] (
    [AudienceAlternateId] BIGINT   IDENTITY (1, 1) NOT NULL,
    [AudienceId]          BIGINT   NULL,
    [TechnicianId]        INT      NULL,
    [CreatedDate]         DATETIME CONSTRAINT [DF_AUDIENCE_ALTERNATE_CreatedDate] DEFAULT (getdate()) NULL,
    [ExcludeTrainingDept] BIT      CONSTRAINT [DF_AUDIENCE_ALTERNATE_ExcludeTrainingDept] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_AUDIENCE_ALTERNATE] PRIMARY KEY CLUSTERED ([AudienceAlternateId] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_AUDIENCE_ALTERNATE_AudienceId_TechnicianId]
    ON [dbo].[AUDIENCE_ALTERNATE]([AudienceId] ASC, [TechnicianId] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Allows user to fall under/view multiple departmental reports - KSK', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AUDIENCE_ALTERNATE', @level2type = N'COLUMN', @level2name = N'AudienceAlternateId';

