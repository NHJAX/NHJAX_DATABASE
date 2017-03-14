CREATE TABLE [dbo].[TICKET_FEEDBACK_FOLLOW_UP] (
    [TicketFeedbackFollowUpId] INT            IDENTITY (1, 1) NOT NULL,
    [Comments]                 VARCHAR (2000) NULL,
    [AssignedTo]               INT            NULL,
    [StatusId]                 INT            CONSTRAINT [DF_TICKET_FEEDBACK_FOLLOW_UP_StatusId] DEFAULT ((1)) NULL,
    [TicketFeedbackId]         INT            NULL,
    [CreatedDate]              DATETIME       CONSTRAINT [DF_TICKET_FEEDBACK_FOLLOW_UP_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]                INT            CONSTRAINT [DF_TICKET_FEEDBACK_FOLLOW_UP_CreatedBy] DEFAULT ((0)) NULL,
    [UpdatedDate]              DATETIME       CONSTRAINT [DF_TICKET_FEEDBACK_FOLLOW_UP_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]                INT            CONSTRAINT [DF_TICKET_FEEDBACK_FOLLOW_UP_UpdatedBy] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_TICKET_FEEDBACK_FOLLOW_UP] PRIMARY KEY CLUSTERED ([TicketFeedbackFollowUpId] ASC)
);

