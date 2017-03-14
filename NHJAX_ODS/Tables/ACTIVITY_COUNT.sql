CREATE TABLE [dbo].[ACTIVITY_COUNT] (
    [ActivityCountId] BIGINT       IDENTITY (1, 1) NOT NULL,
    [ActivityCount]   BIGINT       CONSTRAINT [DF_ACTIVITY_COUNT_ActivityCount] DEFAULT ((1)) NULL,
    [TableName]       VARCHAR (75) NULL,
    [UpdatedDate]     DATETIME     CONSTRAINT [DF_ACTIVITY_COUNT_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_ACTIVITY_COUNT] PRIMARY KEY CLUSTERED ([ActivityCountId] ASC)
);

