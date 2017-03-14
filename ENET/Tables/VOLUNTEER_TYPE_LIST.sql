CREATE TABLE [dbo].[VOLUNTEER_TYPE_LIST] (
    [VolunteerTypeListId] BIGINT   IDENTITY (1, 1) NOT NULL,
    [VolunteerTypeId]     INT      NULL,
    [UserId]              INT      NULL,
    [CreatedDate]         DATETIME CONSTRAINT [DF_VOLUNTEER_TYPE_LIST_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_VOLUNTEER_TYPE_LIST] PRIMARY KEY CLUSTERED ([VolunteerTypeListId] ASC)
);

