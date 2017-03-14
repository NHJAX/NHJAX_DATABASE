CREATE TABLE [dbo].[TICKET_STATUS] (
    [StatusId]    INT          IDENTITY (1, 1) NOT NULL,
    [StatusDesc]  VARCHAR (50) NULL,
    [CreatedBy]   INT          NULL,
    [CreatedDate] DATETIME     CONSTRAINT [DF_TICKET_STATUS_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_TICKET_STATUS] PRIMARY KEY CLUSTERED ([StatusId] ASC)
);

