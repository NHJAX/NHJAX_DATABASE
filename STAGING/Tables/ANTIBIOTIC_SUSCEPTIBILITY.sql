﻿CREATE TABLE [dbo].[ANTIBIOTIC_SUSCEPTIBILITY] (
    [KEY_SITE]                      NUMERIC (5)    NULL,
    [KEY_ANTIBIOTIC_SUSCEPTIBILITY] NUMERIC (9, 3) NULL,
    [ANTIBIOTIC]                    VARCHAR (35)   NULL,
    [ABBREVIATION]                  VARCHAR (3)    NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_ANTIBIOTIC_SUSCEPTIBILITY_KEY_ANTIBIOTIC_SUSCEPTIBILITY]
    ON [dbo].[ANTIBIOTIC_SUSCEPTIBILITY]([KEY_ANTIBIOTIC_SUSCEPTIBILITY] ASC) WITH (FILLFACTOR = 100);
