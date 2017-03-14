CREATE TABLE [dbo].[TICKET_ASSIGNMENT_ARCHIVE] (
    [AssignmentId]   INT             NOT NULL,
    [AssignedTo]     INT             NULL,
    [AssignedBy]     INT             NULL,
    [StatusId]       INT             NULL,
    [AssignmentDate] DATETIME        NULL,
    [ClosedDate]     DATETIME        NULL,
    [ClosedBy]       INT             NULL,
    [TicketId]       INT             NULL,
    [Remarks]        TEXT            NULL,
    [Hours]          DECIMAL (18, 2) NULL,
    [HoursToClose]   INT             NULL,
    [DaysToClose]    INT             NULL,
    [TierId]         INT             NULL,
    [HistoryDate]    DATETIME        CONSTRAINT [DF_TICKET_ASSIGNMENT_ARCHIVE_HistoryDate] DEFAULT (getdate()) NULL
);

