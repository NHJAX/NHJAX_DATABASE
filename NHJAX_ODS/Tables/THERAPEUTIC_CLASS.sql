CREATE TABLE [dbo].[THERAPEUTIC_CLASS] (
    [TherapeuticClassId]   BIGINT        IDENTITY (1, 1) NOT NULL,
    [TherapeuticClassDesc] VARCHAR (108) NULL,
    [CreatedDate]          DATETIME      CONSTRAINT [DF_THERAPEUTIC_CLASS_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_THERAPEUTIC_CLASS] PRIMARY KEY CLUSTERED ([TherapeuticClassId] ASC)
);

