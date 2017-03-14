CREATE TABLE [dbo].[RADIOLOGY_TYPE] (
    [RadiologyTypeId]   BIGINT       IDENTITY (0, 1) NOT NULL,
    [RadiologyTypeDesc] VARCHAR (50) NULL,
    [CreatedDate]       DATETIME     CONSTRAINT [DF_RADIOLOGY_TYPE_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_RADIOLOGY_TYPE] PRIMARY KEY CLUSTERED ([RadiologyTypeId] ASC)
);

