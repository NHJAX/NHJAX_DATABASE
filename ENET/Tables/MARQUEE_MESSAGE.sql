CREATE TABLE [dbo].[MARQUEE_MESSAGE] (
    [MessageId]    INT          IDENTITY (1, 1) NOT NULL,
    [TechMessage1] NTEXT        NULL,
    [TechMessage2] NTEXT        NULL,
    [TechMessage3] NTEXT        NULL,
    [CreatedDate]  DATETIME     CONSTRAINT [DF_MARQUEE_MESSAGE_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]    VARCHAR (50) CONSTRAINT [DF_MARQUEE_MESSAGE_CreatedBy] DEFAULT ((0)) NULL,
    [UpdatedDate]  DATETIME     CONSTRAINT [DF_MARQUEE_MESSAGE_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]    VARCHAR (50) CONSTRAINT [DF_MARQUEE_MESSAGE_UpdatedBy] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_MARQUEE_MESSAGE] PRIMARY KEY CLUSTERED ([MessageId] ASC)
);

