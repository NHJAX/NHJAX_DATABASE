CREATE TABLE [dbo].[TECHNICIAN_HOUR] (
    [TechHour]     DECIMAL (18, 2) NOT NULL,
    [TechHourDesc] VARCHAR (50)    NULL,
    [CreatedDate]  DATETIME        CONSTRAINT [DF_TECHNICIAN_HOUR_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]    INT             CONSTRAINT [DF_TECHNICIAN_HOUR_CreatedBy] DEFAULT ((0)) NULL
);

