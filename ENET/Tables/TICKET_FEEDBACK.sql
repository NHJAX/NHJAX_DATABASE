CREATE TABLE [dbo].[TICKET_FEEDBACK] (
    [TicketFeedbackId]  INT            IDENTITY (1, 1) NOT NULL,
    [TicketId]          INT            NOT NULL,
    [CustomerSatisfied] BIT            CONSTRAINT [DF_TICKET_FEEDBACK_CustomerSatisfied] DEFAULT ((1)) NULL,
    [Comments]          VARCHAR (1000) NULL,
    [CreatedDate]       DATETIME       CONSTRAINT [DF_TICKET_FEEDBACK_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]         INT            CONSTRAINT [DF_TICKET_FEEDBACK_CreatedBy] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_TICKET_FEEDBACK] PRIMARY KEY CLUSTERED ([TicketFeedbackId] ASC)
);

