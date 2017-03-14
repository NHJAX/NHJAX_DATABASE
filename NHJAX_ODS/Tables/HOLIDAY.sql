CREATE TABLE [dbo].[HOLIDAY] (
    [HolidayId]           INT           IDENTITY (1, 1) NOT NULL,
    [HolidayObservedDate] DATE          NULL,
    [HolidayDescription]  NVARCHAR (50) NULL,
    [HolidayType]         INT           CONSTRAINT [DF_Table_1_FederalHoliday] DEFAULT ((1)) NULL,
    [HolidayYear]         INT           NULL,
    CONSTRAINT [PK_HOLIDAY] PRIMARY KEY CLUSTERED ([HolidayId] ASC)
);

