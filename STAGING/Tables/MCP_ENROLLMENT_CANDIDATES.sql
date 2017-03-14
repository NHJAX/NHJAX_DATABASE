CREATE TABLE [dbo].[MCP_ENROLLMENT_CANDIDATES] (
    [KEY_SITE]                      NUMERIC (5)     NULL,
    [KEY_MCP_ENROLLMENT_CANDIDATES] NUMERIC (12, 3) NULL,
    [PATIENT_IEN_IEN]               NUMERIC (21, 3) NULL,
    [PATIENT_NAME]                  VARCHAR (30)    NULL,
    [SSN]                           VARCHAR (10)    NULL,
    [PAT_CATEGORY_IEN]              NUMERIC (21, 3) NULL,
    [PCM_IEN]                       NUMERIC (21, 3) NULL,
    [GROUP_IEN]                     NUMERIC (21, 3) NULL,
    [DIVISION_IEN]                  NUMERIC (21, 3) NULL,
    [PLACE_OF_CARE_IEN]             NUMERIC (21, 3) NULL,
    [ALTERNATE_PCM_IEN]             NUMERIC (21, 3) NULL,
    [SPECIALTY_IEN]                 NUMERIC (21, 3) NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ind_MCP_ENROLLMENT_CANDIDATES]
    ON [dbo].[MCP_ENROLLMENT_CANDIDATES]([KEY_SITE] ASC, [KEY_MCP_ENROLLMENT_CANDIDATES] ASC);

