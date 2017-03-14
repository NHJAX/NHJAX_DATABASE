CREATE TABLE [dbo].[ScheduledToCheckOut] (
    [SSN]                 VARCHAR (11)  NOT NULL,
    [FirstName]           VARCHAR (30)  NULL,
    [MI]                  VARCHAR (1)   NULL,
    [LastName]            VARCHAR (30)  NULL,
    [Status]              VARCHAR (20)  NULL,
    [SiteID]              INT           NULL,
    [CheckOutDate]        DATETIME      NULL,
    [CheckedOut]          DATETIME      NULL,
    [IsProvider]          BIT           NULL,
    [Grade]               VARCHAR (30)  NULL,
    [Reason]              VARCHAR (50)  NULL,
    [ScheduledCheckoutId] BIGINT        IDENTITY (1, 1) NOT NULL,
    [CreatedDate]         DATETIME      CONSTRAINT [DF_ScheduledToCheckOut_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]           INT           CONSTRAINT [DF_ScheduledToCheckOut_CreatedBy] DEFAULT ((0)) NULL,
    [UpdatedBy]           INT           CONSTRAINT [DF_ScheduledToCheckOut_UpdatedBy] DEFAULT ((0)) NULL,
    [UserId]              INT           CONSTRAINT [DF_ScheduledToCheckOut_UserId] DEFAULT ((0)) NULL,
    [ImmediateCheckOut]   BIT           CONSTRAINT [DF_ScheduledToCheckOut_ImmediateCheckOut] DEFAULT ((0)) NULL,
    [OfficialDate]        DATETIME      NULL,
    [TransferDate]        DATETIME      NULL,
    [RetirementDate]      DATETIME      NULL,
    [ChecklistId]         INT           CONSTRAINT [DF_ScheduledToCheckOut_ChecklistId] DEFAULT ((0)) NULL,
    [DoDEDI]              NVARCHAR (10) NULL,
    [CheckoutReasonId]    INT           CONSTRAINT [DF_ScheduledToCheckOut_CheckoutReasonId] DEFAULT ((0)) NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [IX_ScheduledToCheckOut_ScheduledToCheckOutId_PrimaryKey]
    ON [dbo].[ScheduledToCheckOut]([ScheduledCheckoutId] ASC);

