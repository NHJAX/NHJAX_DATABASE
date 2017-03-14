CREATE TABLE [dbo].[LAB_TEST_TYPE] (
    [LabTestTypeId]   BIGINT       NOT NULL,
    [LabTestTypeDesc] VARCHAR (50) NULL,
    [CreatedDate]     DATETIME     CONSTRAINT [DF_LAB_TEST_TYPE_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_LAB_TEST_TYPE] PRIMARY KEY CLUSTERED ([LabTestTypeId] ASC)
);

