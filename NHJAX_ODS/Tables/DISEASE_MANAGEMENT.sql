CREATE TABLE [dbo].[DISEASE_MANAGEMENT] (
    [DiseaseManagementId]   BIGINT        IDENTITY (1, 1) NOT NULL,
    [DiseaseManagementDesc] VARCHAR (100) NULL,
    [CreatedDate]           DATETIME      CONSTRAINT [DF_DISEASE_MANAGEMENT_CreatedDate] DEFAULT (getdate()) NULL,
    [Inactive]              BIT           NULL,
    CONSTRAINT [PK_DISEASE_MANAGEMENT] PRIMARY KEY CLUSTERED ([DiseaseManagementId] ASC)
);

