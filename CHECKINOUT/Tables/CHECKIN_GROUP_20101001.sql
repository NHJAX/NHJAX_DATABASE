CREATE TABLE [dbo].[CHECKIN_GROUP_20101001] (
    [CheckInGroupId]   INT          NULL,
    [CheckInGroupDesc] VARCHAR (50) NULL,
    [CreatedDate]      DATETIME     CONSTRAINT [DF_CHECKIN_GROUP_CreatedDate] DEFAULT (getdate()) NULL,
    [SortOrder]        INT          NULL
);

