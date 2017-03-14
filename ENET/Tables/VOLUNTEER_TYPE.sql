CREATE TABLE [dbo].[VOLUNTEER_TYPE] (
    [VolunteerTypeId]   INT          NOT NULL,
    [VolunteerTypeDesc] VARCHAR (50) NULL,
    [CreatedDate]       DATETIME     CONSTRAINT [DF_VOLUNTEER_TYPE_CreatedDate] DEFAULT (getdate()) NULL,
    [Inactive]          BIT          CONSTRAINT [DF_VOLUNTEER_TYPE_Inactive] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_VOLUNTEER_TYPE] PRIMARY KEY CLUSTERED ([VolunteerTypeId] ASC)
);

