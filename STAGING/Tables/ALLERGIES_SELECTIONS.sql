﻿CREATE TABLE [dbo].[ALLERGIES_SELECTIONS] (
    [KEY_SITE]                 NUMERIC (5)     NULL,
    [KEY_ALLERGIES_SELECTIONS] NUMERIC (16, 3) NULL,
    [BN_GNN]                   VARCHAR (76)    NULL,
    [ALLERGY_DEFINITIONS_IEN]  NUMERIC (21, 3) NULL,
    [COMMENT_]                 VARCHAR (62)    NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ind_ALLERGIES_SELECTIONS]
    ON [dbo].[ALLERGIES_SELECTIONS]([KEY_SITE] ASC, [KEY_ALLERGIES_SELECTIONS] ASC);

