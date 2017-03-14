CREATE TABLE [dbo].[COUNTRY] (
    [CountryId]   INT           NOT NULL,
    [CountryDesc] NVARCHAR (50) NULL,
    [CountryCode] NVARCHAR (2)  NULL,
    CONSTRAINT [PK_COUNTRY] PRIMARY KEY CLUSTERED ([CountryId] ASC)
);

