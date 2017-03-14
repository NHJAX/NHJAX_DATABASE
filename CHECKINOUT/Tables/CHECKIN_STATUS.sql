CREATE TABLE [dbo].[CHECKIN_STATUS] (
    [CheckInStatusId]   INT           NOT NULL,
    [CheckInStatusDesc] VARCHAR (150) NULL,
    [CreatedDate]       DATETIME      CONSTRAINT [DF_CHECKIN_STATUS_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_CHECKIN_STATUS] PRIMARY KEY CLUSTERED ([CheckInStatusId] ASC)
);

