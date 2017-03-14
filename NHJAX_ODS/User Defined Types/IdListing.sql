CREATE TYPE [dbo].[IdListing] AS TABLE (
    [RecordId]             INT          NOT NULL,
    [RecordIdType]         VARCHAR (50) NULL,
    [RecordIdIntegerValue] INT          NULL,
    PRIMARY KEY CLUSTERED ([RecordId] ASC));

