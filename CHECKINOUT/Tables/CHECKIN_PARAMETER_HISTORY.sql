CREATE TABLE [dbo].[CHECKIN_PARAMETER_HISTORY] (
    [CheckInParameterHistoryId] BIGINT        IDENTITY (1, 1) NOT NULL,
    [CheckInParameterId]        BIGINT        NULL,
    [CheckInStepId]             BIGINT        NULL,
    [BaseId]                    INT           NULL,
    [DesignationId]             INT           NULL,
    [SpecialInformation]        VARCHAR (100) NULL,
    [DefaultSortOrder]          INT           NULL,
    [CreatedDate]               DATETIME      NULL,
    [CreatedBy]                 INT           NULL,
    [UpdatedDate]               DATETIME      NULL,
    [UpdatedBy]                 INT           NULL,
    [CheckInTypeId]             INT           NULL,
    [IsGroup]                   BIT           NULL,
    [InstructionsFor]           BIGINT        NULL,
    [HistoryDate]               DATETIME      CONSTRAINT [DF_CHECKIN_PARAMETER_HISTORY_HistoryDate] DEFAULT (getdate()) NULL,
    [HistoryBy]                 INT           CONSTRAINT [DF_CHECKIN_PARAMETER_HISTORY_HistoryBy] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_CHECKIN_PARAMETER_HISTORY] PRIMARY KEY CLUSTERED ([CheckInParameterHistoryId] ASC)
);

