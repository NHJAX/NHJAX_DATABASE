CREATE TABLE [dbo].[RACE] (
    [RaceId]      BIGINT         IDENTITY (1, 1) NOT NULL,
    [RaceKey]     NUMERIC (7, 3) NULL,
    [RaceDesc]    VARCHAR (32)   NULL,
    [RaceCode]    VARCHAR (1)    NULL,
    [CreatedDate] DATETIME       CONSTRAINT [DF_RACE_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate] DATETIME       CONSTRAINT [DF_RACE_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_RACE] PRIMARY KEY CLUSTERED ([RaceId] ASC)
);

