CREATE TABLE [dbo].[PATIENT_CATEGORY] (
    [PatientCategoryId]   BIGINT          IDENTITY (0, 1) NOT NULL,
    [PatientCategoryKey]  DECIMAL (10, 3) NULL,
    [PatientCategoryDesc] VARCHAR (36)    NULL,
    [PatientCategoryCode] VARCHAR (4)     NULL,
    [CreatedDate]         DATETIME        CONSTRAINT [DF_PATIENT_CATEGORY_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]         DATETIME        CONSTRAINT [DF_PATIENT_CATEGORY_UpdatedDate] DEFAULT (getdate()) NULL,
    [ShortDescription]    VARCHAR (22)    NULL,
    CONSTRAINT [PK_PATIENT_CATEGORY] PRIMARY KEY CLUSTERED ([PatientCategoryId] ASC)
);

