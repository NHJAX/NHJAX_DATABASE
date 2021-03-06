﻿CREATE TABLE [dbo].[GEOGRAPHIC_LOCATION] (
    [KEY_SITE]                NUMERIC (5)    NULL,
    [KEY_GEOGRAPHIC_LOCATION] NUMERIC (9, 3) NULL,
    [NAME]                    VARCHAR (50)   NULL,
    [ABBREVIATION]            VARCHAR (5)    NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_GEOGRAPHIC_LOCATION_KEY_GEOGRAPHIC_LOCATION]
    ON [dbo].[GEOGRAPHIC_LOCATION]([KEY_GEOGRAPHIC_LOCATION] ASC) WITH (FILLFACTOR = 100);

