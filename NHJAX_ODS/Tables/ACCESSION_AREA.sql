CREATE TABLE [dbo].[ACCESSION_AREA] (
    [AccessionAreaID]     BIGINT         IDENTITY (1, 1) NOT NULL,
    [AccessionAreaKey]    NUMERIC (9, 3) NOT NULL,
    [AccessionAreaDesc]   VARCHAR (50)   NULL,
    [AccessionTypeID]     BIGINT         NOT NULL,
    [AccessionAreaAbbrev] VARCHAR (50)   NOT NULL,
    [CreatedDate]         DATETIME       CONSTRAINT [DF_ACCESSION_AREA_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [UpdatedDate]         DATETIME       CONSTRAINT [DF_ACCESSION_AREA_UpdatedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ACCESSION_AREA] PRIMARY KEY CLUSTERED ([AccessionAreaID] ASC),
    CONSTRAINT [FK_ACCESSION_AREA_ACCESSION_TYPE] FOREIGN KEY ([AccessionTypeID]) REFERENCES [dbo].[ACCESSION_TYPE] ([AccessionTypeId])
);

