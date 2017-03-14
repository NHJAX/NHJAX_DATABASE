CREATE TABLE [dbo].[DRUG_SCHEDULE] (
    [DrugScheduleCode] VARCHAR (1)  NOT NULL,
    [DrugScheduleDesc] VARCHAR (25) NULL,
    [CreatedDate]      DATETIME     CONSTRAINT [DF_DRUG_SCHEDULE_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_DRUG_SCHEDULE] PRIMARY KEY CLUSTERED ([DrugScheduleCode] ASC)
);

