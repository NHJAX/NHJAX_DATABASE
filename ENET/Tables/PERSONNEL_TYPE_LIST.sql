CREATE TABLE [dbo].[PERSONNEL_TYPE_LIST] (
    [PersonnelTypeListId] BIGINT   IDENTITY (1, 1) NOT NULL,
    [PersonnelTypeId]     INT      NULL,
    [UserId]              INT      NULL,
    [CreatedDate]         DATETIME CONSTRAINT [DF_PERSONNEL_TYPE_LIST_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_PERSONNEL_TYPE_LIST] PRIMARY KEY CLUSTERED ([PersonnelTypeListId] ASC)
);

