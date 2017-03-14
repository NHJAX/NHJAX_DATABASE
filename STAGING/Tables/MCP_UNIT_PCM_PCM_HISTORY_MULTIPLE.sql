CREATE TABLE [dbo].[MCP_UNIT_PCM$PCM_HISTORY_MULTIPLE] (
    [KEY_SITE]                              NUMERIC (5)     NULL,
    [KEY_MCP_UNIT_PCM]                      NUMERIC (12, 3) NULL,
    [KEY_MCP_UNIT_PCM$PCM_HISTORY_MULTIPLE] NUMERIC (8, 3)  NULL,
    [START_DATE]                            DATETIME        NULL,
    [STOP_DATE]                             DATETIME        NULL,
    [PRIMARY_CARE_MANAGER_IEN]              NUMERIC (21, 3) NULL,
    [PROVIDER_GROUP_IEN]                    NUMERIC (21, 3) NULL,
    [PCM_PLACE_OF_CARE_IEN]                 NUMERIC (21, 3) NULL,
    [PCM_SPECIALTY_IEN]                     NUMERIC (21, 3) NULL,
    [PCM_PHONE]                             VARCHAR (18)    NULL,
    [PATIENT_TYPE_IEN]                      NUMERIC (21, 3) NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ind_MCP_UNIT_PCM$PCM_HISTORY_MULTIPLE]
    ON [dbo].[MCP_UNIT_PCM$PCM_HISTORY_MULTIPLE]([KEY_SITE] ASC, [KEY_MCP_UNIT_PCM] ASC, [KEY_MCP_UNIT_PCM$PCM_HISTORY_MULTIPLE] ASC);

