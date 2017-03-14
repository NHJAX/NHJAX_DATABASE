CREATE TABLE [dbo].[REASON_SEEN] (
    [ReasonSeenId]   INT          NOT NULL,
    [ReasonSeenDesc] VARCHAR (50) NULL,
    [CreatedDate]    DATETIME     CONSTRAINT [DF_REASON_SEEN_CreatedDate] DEFAULT (getdate()) NULL,
    [ImageResource]  VARCHAR (50) NULL,
    CONSTRAINT [PK_REASON_SEEN] PRIMARY KEY CLUSTERED ([ReasonSeenId] ASC)
);

