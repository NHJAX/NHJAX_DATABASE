﻿CREATE TABLE [dbo].[CPT_HCPCS$MODIFIER] (
    [KEY_SITE]               NUMERIC (5)     NULL,
    [KEY_CPT_HCPCS]          NUMERIC (11, 3) NULL,
    [KEY_CPT_HCPCS$MODIFIER] NUMERIC (7, 3)  NULL,
    [MODIFIER]               VARCHAR (2)     NULL,
    [DOD_BILLING]            NUMERIC (15, 5) NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ind_CPT_HCPCS$MODIFIER]
    ON [dbo].[CPT_HCPCS$MODIFIER]([KEY_SITE] ASC, [KEY_CPT_HCPCS] ASC, [KEY_CPT_HCPCS$MODIFIER] ASC);

