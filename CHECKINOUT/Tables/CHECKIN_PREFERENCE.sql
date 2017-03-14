CREATE TABLE [dbo].[CHECKIN_PREFERENCE] (
    [CheckInPreferenceId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [BaseId]              INT            NULL,
    [DesignationId]       INT            NULL,
    [PreferenceId]        INT            NULL,
    [PreferenceValue]     VARCHAR (1000) NULL,
    [CreatedDate]         DATETIME       CONSTRAINT [DF_CHECKIN_PREFERENCE_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]           INT            CONSTRAINT [DF_CHECKIN_PREFERENCE_CreatedBy] DEFAULT ((0)) NULL,
    [UpdatedDate]         DATETIME       CONSTRAINT [DF_CHECKIN_PREFERENCE_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]           INT            CONSTRAINT [DF_CHECKIN_PREFERENCE_UpdatedBy] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_CHECKIN_PREFERENCE] PRIMARY KEY CLUSTERED ([CheckInPreferenceId] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_CHECKIN_PREFERENCE_BaseId_DesignationId]
    ON [dbo].[CHECKIN_PREFERENCE]([BaseId] ASC, [DesignationId] ASC, [PreferenceId] ASC);

