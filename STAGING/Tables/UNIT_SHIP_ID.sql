﻿CREATE TABLE [dbo].[UNIT_SHIP_ID] (
    [KEY_SITE]              NUMERIC (5)     NULL,
    [KEY_UNIT_SHIP_ID]      NUMERIC (12, 3) NULL,
    [NAME]                  VARCHAR (30)    NULL,
    [CODE]                  VARCHAR (30)    NULL,
    [BRANCH_OF_SERVICE_IEN] NUMERIC (21, 3) NULL,
    [UNIT_LOCATION_IEN]     NUMERIC (21, 3) NULL,
    [ZIP_CODE_IEN]          NUMERIC (21, 3) NULL,
    [ALIAS]                 VARCHAR (30)    NULL,
    [LOCATION_ABBREVIATION] VARCHAR (15)    NULL,
    [DBA_INACTIVE_FLAG]     VARCHAR (30)    NULL,
    [DEACTIVATION_DATE]     DATETIME        NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_UNIT_SHIP_ID_CODE]
    ON [dbo].[UNIT_SHIP_ID]([CODE] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_UNIT_SHIP_ID_KEY_UNIT_SHIP_ID]
    ON [dbo].[UNIT_SHIP_ID]([KEY_UNIT_SHIP_ID] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_UNIT_SHIP_ID_BRANCH_OF_SERVICE_IEN]
    ON [dbo].[UNIT_SHIP_ID]([BRANCH_OF_SERVICE_IEN] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_UNIT_SHIP_ID_UNIT_LOCATION_IEN]
    ON [dbo].[UNIT_SHIP_ID]([UNIT_LOCATION_IEN] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_UNIT_SHIP_ID_NAME]
    ON [dbo].[UNIT_SHIP_ID]([NAME] ASC) WITH (FILLFACTOR = 100);

