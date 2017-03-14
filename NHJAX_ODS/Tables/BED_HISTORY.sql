CREATE TABLE [dbo].[BED_HISTORY] (
    [BedHistoryId] BIGINT        IDENTITY (1, 1) NOT NULL,
    [BedId]        BIGINT        NULL,
    [BedKey]       VARCHAR (254) NULL,
    [BedStatusId]  INT           CONSTRAINT [DF_BED_HISTORY_BedStatusId] DEFAULT ((0)) NULL,
    [PatientId]    BIGINT        NULL,
    [BedNumber]    VARCHAR (2)   NULL,
    [DepartmentId] BIGINT        NULL,
    [BedDesc]      VARCHAR (30)  NULL,
    [CreatedDate]  DATETIME      NULL,
    [UpdatedDate]  DATETIME      NULL,
    [Inactive]     BIT           NULL,
    [HistoryDate]  DATETIME      CONSTRAINT [DF_BED_HISTORY_HistoryDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_BED_HISTORY] PRIMARY KEY CLUSTERED ([BedHistoryId] ASC)
);

