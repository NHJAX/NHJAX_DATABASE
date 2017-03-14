CREATE TABLE [dbo].[DM_DIABETES_ENCOUNTER_TYPE] (
    [EncounterTypeId]   INT           NOT NULL,
    [EncounterTypeDesc] NVARCHAR (50) NOT NULL,
    [CreatedDate]       DATETIME      CONSTRAINT [DF_DM_DIABETES_ENCOUNTER_TYPE_CreatedDate] DEFAULT (getdate()) NOT NULL
);

