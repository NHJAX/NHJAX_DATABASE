CREATE TABLE [dbo].[TICKET_FEEDBACK_FOLLOW_UP_ARCHIVE] (
    [TicketFeedbackFollowUpId] INT            NOT NULL,
    [Comments]                 VARCHAR (2000) NULL,
    [AssignedTo]               INT            NULL,
    [StatusId]                 INT            NULL,
    [TicketFeedbackId]         INT            NULL,
    [CreatedDate]              DATETIME       NULL,
    [CreatedBy]                INT            NULL,
    [UpdatedDate]              DATETIME       NULL,
    [UpdatedBy]                INT            NULL
);

