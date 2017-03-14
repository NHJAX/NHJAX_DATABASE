CREATE TABLE [dbo].[PERSONNEL_INPROCESS] (
    [PersonnelInProcessId] BIGINT        IDENTITY (1, 1) NOT NULL,
    [PersonnelId]          BIGINT        NULL,
    [CheckInStepId]        BIGINT        NULL,
    [InstructionsFor]      BIGINT        NULL,
    [PersonnelTypeId]      INT           NULL,
    [SortOrder]            INT           NULL,
    [CheckInStepDesc]      VARCHAR (50)  NULL,
    [SpecialInformation]   VARCHAR (100) NULL,
    [CreatedDate]          DATETIME      CONSTRAINT [DF_PERSONNEL_INPROCESS_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]            INT           CONSTRAINT [DF_PERSONNEL_INPROCESS_CreatedBy] DEFAULT ((0)) NULL,
    [IsDefault]            BIT           CONSTRAINT [DF_PERSONNEL_INPROCESS_IsDefault] DEFAULT ((0)) NULL,
    [IsGroup]              BIT           CONSTRAINT [DF_PERSONNEL_INPROCESS_CheckInGroupId] DEFAULT ((0)) NULL,
    [DesignationId]        INT           CONSTRAINT [DF_PERSONNEL_INPROCESS_DesignationId] DEFAULT ((0)) NULL,
    [BaseId]               INT           CONSTRAINT [DF_PERSONNEL_INPROCESS_BaseId] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_PERSONNEL_INPROCESS] PRIMARY KEY CLUSTERED ([PersonnelInProcessId] ASC),
    CONSTRAINT [FK_PERSONNEL_INPROCESS_PERSONNEL] FOREIGN KEY ([PersonnelId]) REFERENCES [dbo].[PERSONNEL] ([PersonnelId]) ON DELETE CASCADE
);

