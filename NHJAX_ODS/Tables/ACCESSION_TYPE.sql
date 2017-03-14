CREATE TABLE [dbo].[ACCESSION_TYPE] (
    [AccessionTypeId]   BIGINT       NOT NULL,
    [AccessionTypeDesc] VARCHAR (50) NULL,
    [CreatedDate]       DATETIME     CONSTRAINT [DF_LAB_TYPE_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_LAB_TYPE] PRIMARY KEY CLUSTERED ([AccessionTypeId] ASC)
);

