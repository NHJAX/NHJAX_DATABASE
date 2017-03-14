CREATE TABLE [dbo].[ACCESSION] (
    [AccessionID]             NUMERIC (5)      IDENTITY (1, 1) NOT NULL,
    [AccessionKey]            NUMERIC (13, 3)  NOT NULL,
    [LabArrivalTime]          DATETIME         NOT NULL,
    [RequestionLocationIEN]   NUMERIC (22, 4)  NOT NULL,
    [CurrentAccessionName]    VARCHAR (15)     NOT NULL,
    [CurrentAccessionAreaIen] NUMERIC (21, 21) NOT NULL,
    [CreatedDate]             DATETIME         CONSTRAINT [DF_ACCESSION_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]             DATETIME         CONSTRAINT [DF_ACCESSION_UpdateDate] DEFAULT (getdate()) NULL
);

