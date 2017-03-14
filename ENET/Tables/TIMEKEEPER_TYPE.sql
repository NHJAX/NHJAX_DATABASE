CREATE TABLE [dbo].[TIMEKEEPER_TYPE] (
    [TimekeeperTypeId]   INT           NOT NULL,
    [TimekeeperTypeDesc] NVARCHAR (50) NULL,
    [CreatedDate]        DATETIME      CONSTRAINT [DF_TIMEKEEPER_TYPE_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_TIMEKEEPER_TYPE] PRIMARY KEY CLUSTERED ([TimekeeperTypeId] ASC)
);

