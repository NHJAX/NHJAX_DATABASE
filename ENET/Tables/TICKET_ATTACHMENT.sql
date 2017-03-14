CREATE TABLE [dbo].[TICKET_ATTACHMENT] (
    [TicketAttachmentId] BIGINT        IDENTITY (1, 1) NOT NULL,
    [TicketId]           INT           NULL,
    [AttachmentName]     VARCHAR (250) NULL,
    [ShortName]          VARCHAR (250) NULL,
    [CreatedDate]        DATETIME      CONSTRAINT [DF_TICKET_ATTACHMENT_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]          INT           CONSTRAINT [DF_TICKET_ATTACHMENT_CreatedBy] DEFAULT ((0)) NULL,
    [DeletedDate]        DATETIME      NULL,
    [DeletedBy]          INT           NULL,
    CONSTRAINT [PK_TICKET_ATTACHMENT] PRIMARY KEY CLUSTERED ([TicketAttachmentId] ASC)
);

