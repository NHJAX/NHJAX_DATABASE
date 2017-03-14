CREATE TABLE [dbo].[ORDER_ENCOUNTER_TYPE] (
    [OrderEncounterTypeId]   BIGINT       NOT NULL,
    [OrderEncounterTypeDesc] VARCHAR (50) NULL,
    [CreatedDate]            DATETIME     CONSTRAINT [DF_PATIENT_ENCOUNTER_TYPE_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_PATIENT_ENCOUNTER_TYPE] PRIMARY KEY CLUSTERED ([OrderEncounterTypeId] ASC)
);

