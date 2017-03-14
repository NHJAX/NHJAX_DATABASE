CREATE TABLE [dbo].[sessTICKET_ATTACHMENT] (
    [SessionKey]     VARCHAR (100) NULL,
    [AttachmentName] VARCHAR (250) NULL,
    [ShortName]      VARCHAR (250) NULL,
    [CreatedDate]    DATETIME      CONSTRAINT [DF_sessTICKET_ATTACHMENT_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]      INT           CONSTRAINT [DF_sessTICKET_ATTACHMENT_CreatedBy] DEFAULT ((0)) NULL
);

