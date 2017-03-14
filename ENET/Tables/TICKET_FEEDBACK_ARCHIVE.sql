CREATE TABLE [dbo].[TICKET_FEEDBACK_ARCHIVE] (
    [TicketFeedbackId]  INT            NOT NULL,
    [TicketId]          INT            NOT NULL,
    [CustomerSatisfied] BIT            NULL,
    [Comments]          VARCHAR (1000) NULL,
    [CreatedDate]       DATETIME       NULL,
    [CreatedBy]         INT            NULL
);

