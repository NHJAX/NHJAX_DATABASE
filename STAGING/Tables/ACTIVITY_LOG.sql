CREATE TABLE [dbo].[ACTIVITY_LOG] (
    [LogId]          BIGINT   IDENTITY (1, 1) NOT NULL,
    [LogDescription] TEXT     NULL,
    [CreatedDate]    DATETIME CONSTRAINT [DF_ACTIVITY_LOG_CreatedDate] DEFAULT (getdate()) NULL,
    [DayofWeek]      INT      CONSTRAINT [DF_ACTIVITY_LOG_DayofWeek] DEFAULT (datepart(weekday,getdate())) NULL,
    [ErrorNumber]    INT      CONSTRAINT [DF_ACTIVITY_LOG_ErrorNumber] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_ACTIVITY_LOG] PRIMARY KEY CLUSTERED ([LogId] ASC)
);

