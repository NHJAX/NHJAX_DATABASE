CREATE TABLE [dbo].[DM_DIABETES_LAB_RESULT_TYPE] (
    [LabResultTypeId]   INT           NOT NULL,
    [LabResultTypeDesc] NVARCHAR (50) NOT NULL,
    [CreatedDate]       DATETIME      CONSTRAINT [DF_DM_DIABETES_TYPE_CreatedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_DM_DIABETES_TYPE] PRIMARY KEY CLUSTERED ([LabResultTypeId] ASC)
);

