﻿CREATE TABLE [dbo].[DRUG$ASSOCIATED_FORMULARY] (
    [KEY_SITE]                      NUMERIC (5)     NULL,
    [KEY_DRUG]                      NUMERIC (14, 3) NULL,
    [KEY_DRUG$ASSOCIATED_FORMULARY] NUMERIC (8, 3)  NULL,
    [ASSOCIATED_FORMULARY_IEN]      NUMERIC (21, 3) NULL,
    [LOCAL_COST]                    NUMERIC (18, 5) NULL,
    [PDTS_UNIT_COST]                NUMERIC (18, 5) NULL,
    [NON_FORMULARY]                 VARCHAR (30)    NULL,
    [LOCAL_PDTS_COST_SWITCH]        VARCHAR (30)    NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_DRUG$ASSOCIATED_FORMULARY_KEY_DRUG]
    ON [dbo].[DRUG$ASSOCIATED_FORMULARY]([KEY_DRUG] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_DRUG$ASSOCIATED_FORMULARY_KEY_DRUG$ASSOCIATED_FORMULARY]
    ON [dbo].[DRUG$ASSOCIATED_FORMULARY]([KEY_DRUG$ASSOCIATED_FORMULARY] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_DRUG$ASSOCIATED_FORMULARY_ASSOCIATED_FORMULARY_IEN]
    ON [dbo].[DRUG$ASSOCIATED_FORMULARY]([ASSOCIATED_FORMULARY_IEN] ASC) WITH (FILLFACTOR = 100);

