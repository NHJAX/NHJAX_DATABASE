CREATE TABLE [dbo].[sessINV_DISPLAY] (
    [SessionKey]      INT      IDENTITY (1, 1) NOT NULL,
    [DisplayColumnId] INT      NULL,
    [CreatedBy]       INT      NULL,
    [CreatedDate]     DATETIME CONSTRAINT [DF_sessINV_DISPLAY_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_sessINV_DISPLAY] PRIMARY KEY CLUSTERED ([SessionKey] ASC)
);

