﻿CREATE TABLE [dbo].[NED_HCDP_COVERAGE_CODE] (
    [KEY_SITE]                   NUMERIC (5)    NULL,
    [KEY_NED_HCDP_COVERAGE_CODE] NUMERIC (9, 3) NULL,
    [CODE]                       VARCHAR (3)    NULL,
    [TEXT]                       VARCHAR (125)  NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_NED_HCDP_COVERAGE_CODE_KEY_NED_HCDP_COVERAGE_CODE]
    ON [dbo].[NED_HCDP_COVERAGE_CODE]([KEY_NED_HCDP_COVERAGE_CODE] ASC) WITH (FILLFACTOR = 100);

