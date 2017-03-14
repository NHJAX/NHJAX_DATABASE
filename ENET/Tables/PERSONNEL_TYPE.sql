CREATE TABLE [dbo].[PERSONNEL_TYPE] (
    [PersonnelTypeId]   INT          NOT NULL,
    [PersonnelTypeDesc] VARCHAR (50) NULL,
    [CreatedDate]       DATETIME     CONSTRAINT [DF_PERSONNEL_TYPE_CreatedDate] DEFAULT (getdate()) NULL,
    [Inactive]          BIT          CONSTRAINT [DF_PERSONNEL_TYPE_Inactive] DEFAULT ((0)) NULL,
    [CorpsCode]         VARCHAR (3)  NULL,
    CONSTRAINT [PK_PERSONNEL_TYPE] PRIMARY KEY CLUSTERED ([PersonnelTypeId] ASC)
);

