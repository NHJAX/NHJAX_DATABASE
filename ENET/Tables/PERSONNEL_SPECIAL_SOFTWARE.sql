CREATE TABLE [dbo].[PERSONNEL_SPECIAL_SOFTWARE] (
    [PersonnelSpecialSoftwareId] BIGINT   IDENTITY (1, 1) NOT NULL,
    [UserId]                     INT      NULL,
    [AudienceId]                 BIGINT   NULL,
    [CreatedDate]                DATETIME CONSTRAINT [DF_PERSONNEL_SPECIAL_SOFTWARE_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_PERSONNEL_SPECIAL_SOFTWARE] PRIMARY KEY CLUSTERED ([PersonnelSpecialSoftwareId] ASC)
);

