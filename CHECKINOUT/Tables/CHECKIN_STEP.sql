CREATE TABLE [dbo].[CHECKIN_STEP] (
    [CheckInStepId]      BIGINT        IDENTITY (1, 1) NOT NULL,
    [CheckInStepDesc]    VARCHAR (50)  NULL,
    [CreatedDate]        DATETIME      CONSTRAINT [DF_CHECKIN_STEP_CreatedDate] DEFAULT (getdate()) NULL,
    [Inactive]           BIT           CONSTRAINT [DF_CHECKIN_STEP_Inactive] DEFAULT ((0)) NULL,
    [IsDefault]          BIT           CONSTRAINT [DF_CHECKIN_STEP_IsDefault] DEFAULT ((0)) NULL,
    [InstructionsFor]    BIGINT        CONSTRAINT [DF_CHECKIN_STEP_InstructionsFor] DEFAULT ((0)) NULL,
    [PersonnelTypeId]    INT           CONSTRAINT [DF_CHECKIN_STEP_PersonnelTypeId] DEFAULT ((0)) NULL,
    [SpecialInformation] VARCHAR (100) NULL,
    [UpdatedDate]        DATETIME      CONSTRAINT [DF_CHECKIN_STEP_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]          INT           CONSTRAINT [DF_CHECKIN_STEP_UpdatedBy] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_CHECKIN_STEP] PRIMARY KEY CLUSTERED ([CheckInStepId] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Recursive list of sub steps.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CHECKIN_STEP', @level2type = N'COLUMN', @level2name = N'InstructionsFor';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Used only if this is an exception based on personnel type', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CHECKIN_STEP', @level2type = N'COLUMN', @level2name = N'PersonnelTypeId';

