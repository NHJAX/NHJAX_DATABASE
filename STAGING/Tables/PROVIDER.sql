CREATE TABLE [dbo].[PROVIDER] (
    [KEY_SITE]                      NUMERIC (5)     NULL,
    [KEY_PROVIDER]                  NUMERIC (11, 3) NULL,
    [NAME]                          VARCHAR (31)    NULL,
    [DUTY_PHONE_1]                  VARCHAR (18)    NULL,
    [PAGER_#]                       VARCHAR (18)    NULL,
    [CLASS_IEN]                     NUMERIC (21, 3) NULL,
    [PROVIDER_ID]                   VARCHAR (30)    NULL,
    [SSN]                           VARCHAR (30)    NULL,
    [TERMINATION_DATE]              DATETIME        NULL,
    [ORDER_ENTRY_INACTIVATION_DATE] DATETIME        NULL,
    [LOCATION_IEN]                  NUMERIC (22, 4) NULL,
    [RANK_IEN]                      NUMERIC (21, 3) NULL,
    [CLINIC_ID_IEN]                 NUMERIC (21, 3) NULL,
    [DEPARTMENT_ID_CODE_IEN]        NUMERIC (21, 3) NULL,
    [LICENSE_#]                     VARCHAR (20)    NULL,
    [LICENSE_TYPE_IEN]              VARCHAR (15)    NULL,
    [PROVIDER_FLAG]                 VARCHAR (30)    NULL,
    [MILITARY_SPECIALITY_IEN]       NUMERIC (21, 3) NULL,
    [EDI_PN]                        VARCHAR (30)    NULL,
    [NPI_ID]                        NUMERIC (16, 3) NULL,
    [REMOTE_REPORTING_DIVISION_IEN] NUMERIC (21, 3) NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_PROVIDER_KEY_PROVIDER]
    ON [dbo].[PROVIDER]([KEY_PROVIDER] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_PROVIDER_PROVIDER_ID]
    ON [dbo].[PROVIDER]([PROVIDER_ID] ASC) WITH (FILLFACTOR = 100);

