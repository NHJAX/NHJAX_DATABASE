CREATE TABLE [dbo].[MARITAL_STATUS] (
    [MaritalStatusId]   BIGINT         IDENTITY (1, 1) NOT NULL,
    [MaritalStatusKey]  NUMERIC (7, 3) NULL,
    [MaritalStatusDesc] VARCHAR (30)   NULL,
    [MaritalStatusAbbr] VARCHAR (5)    NULL,
    [CreatedDate]       DATETIME       CONSTRAINT [DF_MARITAL_STATUS_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]       DATETIME       CONSTRAINT [DF_MARITAL_STATUS_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_MARITAL_STATUS] PRIMARY KEY CLUSTERED ([MaritalStatusId] ASC)
);

