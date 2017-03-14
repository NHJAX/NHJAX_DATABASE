CREATE TABLE [dbo].[sessCurrentDMHRSiPositions] (
    [CurrentDMHRSiPositionsId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [OrganizationName]         NVARCHAR (255) NULL,
    [OfficialPositionName]     NVARCHAR (255) NULL,
    [PositionStartDate]        NVARCHAR (255) NULL,
    [PositionService]          NVARCHAR (255) NULL,
    [PositionUIC]              NVARCHAR (255) NULL,
    [PositionBillet]           NVARCHAR (255) NULL,
    [PositionTitle]            NVARCHAR (255) NULL,
    [Blank]                    NVARCHAR (255) NULL,
    [PositionRank]             NVARCHAR (255) NULL,
    [PositionManpowerType]     NVARCHAR (255) NULL,
    [DMHRSiPositionNumber]     NVARCHAR (255) NULL,
    [HiringStatus]             NVARCHAR (255) NULL,
    [BIN]                      NVARCHAR (255) NULL,
    [PositionJob]              NVARCHAR (255) NULL,
    [CreatedDate]              DATETIME       CONSTRAINT [DF_sessCurrentDMHRSiPositions_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]                INT            CONSTRAINT [DF_sessCurrentDMHRSiPositions_CreatedBy] DEFAULT ((0)) NULL,
    [IsProcessed]              BIT            CONSTRAINT [DF_sessCurrentDMHRSiPositions_IsProcessed] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_sessCurrentDMHRSiPositions] PRIMARY KEY CLUSTERED ([CurrentDMHRSiPositionsId] ASC)
);

