CREATE TABLE [dbo].[ETHNICITY] (
    [EthnicityId]   INT          NOT NULL,
    [EthnicityDesc] VARCHAR (50) NULL,
    [CreatedDate]   DATETIME     CONSTRAINT [DF_ETHNICITY_CreatedDate] DEFAULT (getdate()) NULL,
    [EthnicityCode] NVARCHAR (1) NULL,
    CONSTRAINT [PK_ETHNICITY] PRIMARY KEY CLUSTERED ([EthnicityId] ASC)
);

