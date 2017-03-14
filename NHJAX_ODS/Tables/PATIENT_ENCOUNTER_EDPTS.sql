CREATE TABLE [dbo].[PATIENT_ENCOUNTER_EDPTS] (
    [PatientEncounterId] BIGINT          NOT NULL,
    [EncounterKey]       NUMERIC (13, 3) NULL,
    [TimeTriage]         DATETIME        NULL,
    [TimeInRoom]         DATETIME        NULL,
    [TimeProvider]       DATETIME        NULL,
    [CreatedDate]        DATETIME        CONSTRAINT [DF_PATIENT_ENCOUNTER_EDPTS_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]        DATETIME        CONSTRAINT [DF_PATIENT_ENCOUNTER_EDPTS_UpdatedDate] DEFAULT (getdate()) NULL,
    [RoomId]             INT             NULL,
    [Triage]             INT             NULL,
    CONSTRAINT [PK_PATIENT_ENCOUNTER_EDPTS] PRIMARY KEY CLUSTERED ([PatientEncounterId] ASC)
);

