CREATE TABLE [dbo].[VITAL_TYPE] (
    [VitalTypeId]   INT          NOT NULL,
    [VitalTypeDesc] VARCHAR (50) NULL,
    [CreatedDate]   DATETIME     CONSTRAINT [DF_VITAL_TYPE_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_VITAL_TYPE] PRIMARY KEY CLUSTERED ([VitalTypeId] ASC)
);

