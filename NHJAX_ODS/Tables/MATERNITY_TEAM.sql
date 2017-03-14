CREATE TABLE [dbo].[MATERNITY_TEAM] (
    [MaternityTeamId]   INT          NOT NULL,
    [MaternityTeamDesc] VARCHAR (50) NULL,
    [CreatedDate]       DATETIME     CONSTRAINT [DF_MATERNITY_TEAM_CreatedDate] DEFAULT (getdate()) NULL,
    [Inactive]          BIT          CONSTRAINT [DF_MATERNITY_TEAM_Inactive] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_MATERNITY_TEAM] PRIMARY KEY CLUSTERED ([MaternityTeamId] ASC)
);

