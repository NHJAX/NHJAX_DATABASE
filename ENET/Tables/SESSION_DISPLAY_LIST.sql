CREATE TABLE [dbo].[SESSION_DISPLAY_LIST] (
    [SessionDisplayListId]   INT          NOT NULL,
    [SessionDisplayListDesc] VARCHAR (50) NULL,
    [CreatedDate]            DATETIME     CONSTRAINT [DF_SESSION_DISPLAY_LIST_CreatedDate] DEFAULT (getdate()) NULL,
    [IsNotDisplayed]         BIT          CONSTRAINT [DF_SESSION_DISPLAY_LIST_IsNotDisplayed] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_SESSION_DISPLAY_LIST] PRIMARY KEY CLUSTERED ([SessionDisplayListId] ASC)
);

