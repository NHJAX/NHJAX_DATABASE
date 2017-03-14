CREATE TABLE [dbo].[VITAL] (
    [VitalId]            BIGINT       IDENTITY (1, 1) NOT NULL,
    [VitalTypeId]        INT          NULL,
    [PatientEncounterId] BIGINT       NULL,
    [Result]             VARCHAR (50) NULL,
    [CreatedDate]        DATETIME     CONSTRAINT [DF_VITAL_CreatedDate] DEFAULT (getdate()) NULL,
    [ResultBMI]          AS           (isnumeric([Result])),
    CONSTRAINT [PK_VITAL] PRIMARY KEY CLUSTERED ([VitalId] ASC),
    CONSTRAINT [FK_VITAL_PATIENT_ENCOUNTER] FOREIGN KEY ([PatientEncounterId]) REFERENCES [dbo].[PATIENT_ENCOUNTER] ([PatientEncounterId]),
    CONSTRAINT [FK_VITAL_VITAL_TYPE] FOREIGN KEY ([VitalTypeId]) REFERENCES [dbo].[VITAL_TYPE] ([VitalTypeId])
);


GO
CREATE NONCLUSTERED INDEX [IX_VITAL_PatientEncounterId,Result]
    ON [dbo].[VITAL]([PatientEncounterId] ASC, [Result] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_VITAL_PatientEncounterId]
    ON [dbo].[VITAL]([VitalTypeId] ASC, [Result] ASC)
    INCLUDE([PatientEncounterId]);

