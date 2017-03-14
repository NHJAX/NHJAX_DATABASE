CREATE TABLE [dbo].[BED_STATUS] (
    [BedStatusId]   INT          NOT NULL,
    [BedStatusDesc] VARCHAR (50) NULL,
    [CreatedDate]   DATETIME     CONSTRAINT [DF_BED_STATUS_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_BED_STATUS] PRIMARY KEY CLUSTERED ([BedStatusId] ASC)
);

