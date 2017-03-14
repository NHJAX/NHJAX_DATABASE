CREATE TABLE [dbo].[STG_PATIENT_PROVIDER] (
    [KEY_NED_PATIENT]                   NUMERIC (13, 3) NULL,
    [PCM_IEN]                           NUMERIC (21, 3) NULL,
    [PCM_PROJECTED_END_DATE]            VARCHAR (10)    NULL,
    [DMIS_ID_IEN]                       NUMERIC (21, 3) NULL,
    [MaxEnr]                            NUMERIC (17, 3) NULL,
    [MaxPcm]                            NUMERIC (17, 3) NULL,
    [HCDP_CONTRACTOR_COVERAGE_CODE_IEN] NUMERIC (21, 3) NULL,
    [BENEFICIARY_CATEGORY_IEN]          NUMERIC (21, 3) NULL,
    [CreatedDate]                       DATETIME        CONSTRAINT [DF_STG_PATIENT_PROVIDER_CreatedDate] DEFAULT (getdate()) NULL
);

