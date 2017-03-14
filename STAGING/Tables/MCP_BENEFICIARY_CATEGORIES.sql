﻿CREATE TABLE [dbo].[MCP_BENEFICIARY_CATEGORIES] (
    [KEY_SITE]                       NUMERIC (5)    NULL,
    [KEY_MCP_BENEFICIARY_CATEGORIES] NUMERIC (8, 3) NULL,
    [CODE]                           VARCHAR (30)   NULL,
    [DESCRIPTION]                    VARCHAR (30)   NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_MCP_BENEFICIARY_CATEGORIES_KEY_MCP_BENEFICIARY_CATEGORIES]
    ON [dbo].[MCP_BENEFICIARY_CATEGORIES]([KEY_MCP_BENEFICIARY_CATEGORIES] ASC) WITH (FILLFACTOR = 100);
