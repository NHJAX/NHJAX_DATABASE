CREATE TABLE [dbo].[GEOGRAPHIC_LOCATION] (
    [GeographicLocationId]     BIGINT         IDENTITY (1, 1) NOT NULL,
    [GeographicLocationKey]    NUMERIC (9, 3) NULL,
    [GeographicLocationDesc]   VARCHAR (50)   NULL,
    [GeographicLocationAbbrev] VARCHAR (5)    NULL,
    [CreatedDate]              DATETIME       CONSTRAINT [DF_GEOGRAPHIC_LOCATION_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]              DATETIME       CONSTRAINT [DF_GEOGRAPHIC_LOCATION_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_GEOGRAPHIC_LOCATION] PRIMARY KEY CLUSTERED ([GeographicLocationId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_GEOGRAPHIC_LOCATION_KEY]
    ON [dbo].[GEOGRAPHIC_LOCATION]([GeographicLocationKey] ASC);

