CREATE TABLE [dbo].[PERSONNEL_CHECKIN] (
    [PersonnelCheckinId]    BIGINT   IDENTITY (1, 1) NOT NULL,
    [PersonnelId]           BIGINT   NULL,
    [AudienceId]            BIGINT   NULL,
    [CreatedDate]           DATETIME CONSTRAINT [DF_PERSONNEL_CHECKIN_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]           DATETIME CONSTRAINT [DF_PERSONNEL_CHECKIN_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]             INT      CONSTRAINT [DF_PERSONNEL_CHECKIN_UpdatedBy] DEFAULT ((0)) NULL,
    [CheckinStatusId]       INT      CONSTRAINT [DF_PERSONNEL_CHECKIN_CheckinStatusId] DEFAULT ((0)) NULL,
    [CreateActiveDirectory] BIT      CONSTRAINT [DF_PERSONNEL_CHECKIN_CreateActiveDirectory] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_PERSONNEL_CHECKIN] PRIMARY KEY CLUSTERED ([PersonnelCheckinId] ASC),
    CONSTRAINT [FK_PERSONNEL_CHECKIN_PERSONNEL] FOREIGN KEY ([PersonnelId]) REFERENCES [dbo].[PERSONNEL] ([PersonnelId]) ON DELETE CASCADE
);

