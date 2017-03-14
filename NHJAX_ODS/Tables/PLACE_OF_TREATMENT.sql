CREATE TABLE [dbo].[PLACE_OF_TREATMENT] (
    [PlaceofTreatmentId]   BIGINT       IDENTITY (1, 1) NOT NULL,
    [PlaceofTreatmentDesc] VARCHAR (50) NULL,
    [CreatedDate]          DATE         CONSTRAINT [DF_PLACE_OF_TREATMENT_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_PLACE_OF_TREATMENT] PRIMARY KEY CLUSTERED ([PlaceofTreatmentId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_PLACE_OF_TREATMENT_PlaceofTreatmentDesc]
    ON [dbo].[PLACE_OF_TREATMENT]([PlaceofTreatmentDesc] ASC);

