CREATE TABLE [dbo].[CHECKLIST] (
    [ChecklistId]   INT           NOT NULL,
    [ChecklistDesc] VARCHAR (100) NULL,
    [CreatedDate]   DATETIME      CONSTRAINT [DF_CHECKLIST_CreatedDate] DEFAULT (getdate()) NULL,
    [Inactive]      BIT           CONSTRAINT [DF_CHECKLIST_Inactive] DEFAULT ((0)) NULL,
    [IsCheckIn]     BIT           NULL,
    CONSTRAINT [PK_CHECKLIST] PRIMARY KEY CLUSTERED ([ChecklistId] ASC)
);

