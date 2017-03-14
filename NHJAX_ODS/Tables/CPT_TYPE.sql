CREATE TABLE [dbo].[CPT_TYPE] (
    [CptTypeId]   BIGINT       NOT NULL,
    [CptTypeDesc] VARCHAR (50) NULL,
    [CreatedDate] DATETIME     CONSTRAINT [DF_CPT_TYPE_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_CPT_TYPE] PRIMARY KEY CLUSTERED ([CptTypeId] ASC)
);

