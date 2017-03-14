CREATE TABLE [dbo].[PATIENT] (
    [KEY_SITE]                       NUMERIC (5)     NULL,
    [KEY_PATIENT]                    NUMERIC (13, 3) NULL,
    [NAME]                           VARCHAR (30)    NULL,
    [CORRECT_PATIENT_IEN]            NUMERIC (21, 3) NULL,
    [SEX]                            VARCHAR (30)    NULL,
    [DOB]                            DATETIME        NULL,
    [AGE]                            NUMERIC (21, 3) NULL,
    [DISPLAY_AGE]                    VARCHAR (15)    NULL,
    [MARITAL_STATUS_IEN]             NUMERIC (21, 3) NULL,
    [RACE_IEN]                       NUMERIC (21, 3) NULL,
    [RELIGION_IEN]                   NUMERIC (21, 3) NULL,
    [SSN]                            VARCHAR (30)    NULL,
    [PSEUDO_PATIENT]                 VARCHAR (30)    NULL,
    [REGISTRATION_INCOMPLETE]        VARCHAR (30)    NULL,
    [WARD_LOCATION]                  VARCHAR (30)    NULL,
    [PROVIDER_IEN]                   NUMERIC (21, 3) NULL,
    [MEPRS_CODE_IEN]                 NUMERIC (21, 3) NULL,
    [DEERS_ADDRESS_UPDATED]          VARCHAR (30)    NULL,
    [DEERS_DISCREPANCY_CODE_IEN]     NUMERIC (21, 3) NULL,
    [DEERS_ADDRESS_UPDATE_DATE]      DATETIME        NULL,
    [STREET_ADDRESS]                 VARCHAR (50)    NULL,
    [STREET_ADDRESS_2]               VARCHAR (36)    NULL,
    [STREET_ADDRESS_3]               VARCHAR (30)    NULL,
    [CITY]                           VARCHAR (30)    NULL,
    [STATE_IEN]                      NUMERIC (21, 3) NULL,
    [ZIP_CODE]                       VARCHAR (10)    NULL,
    [COUNTY]                         NUMERIC (9, 3)  NULL,
    [DOD_ID_#]                       VARCHAR (10)    NULL,
    [PHONE]                          VARCHAR (20)    NULL,
    [OFFICE_PHONE]                   VARCHAR (20)    NULL,
    [DSN]                            VARCHAR (8)     NULL,
    [FAX_NUMBER]                     VARCHAR (18)    NULL,
    [PATIENT_SSN]                    VARCHAR (30)    NULL,
    [BRANCH_OF_SERVICE_LAST_IEN]     NUMERIC (21, 3) NULL,
    [PREFERRED_CONTACT_METHOD_IEN]   NUMERIC (21, 3) NULL,
    [FMP_SSN]                        VARCHAR (15)    NULL,
    [SPONSOR_SSN]                    VARCHAR (15)    NULL,
    [FMP_IEN]                        NUMERIC (21, 3) NULL,
    [SECOND_FMP_SSN]                 VARCHAR (30)    NULL,
    [REGISTRATION_TYPE]              VARCHAR (30)    NULL,
    [UNIT_SHIP_ID_IEN]               NUMERIC (21, 3) NULL,
    [PATIENT_CATEGORY_IEN]           NUMERIC (21, 3) NULL,
    [PRIMARY_PHYSICIAN_IEN]          NUMERIC (21, 3) NULL,
    [ACTIVE_DUTY]                    VARCHAR (15)    NULL,
    [MILITARY_GRADE_RANK_IEN]        VARCHAR (15)    NULL,
    [OUTPATIENT_RECORD_LOCATION_IEN] VARCHAR (64)    NULL,
    [POLICY_NUMBER]                  VARCHAR (30)    NULL,
    [DEERS_SPONSOR_STATUS_IEN]       NUMERIC (21, 3) NULL,
    [DEERS_UIC_IEN]                  NUMERIC (21, 3) NULL,
    [MEMBER_RELATIONSHIP_CODE]       VARCHAR (30)    NULL,
    [NED_PATIENT_LAST_NAME]          VARCHAR (30)    NULL,
    [NED_PATIENT_FIRST_NAME]         VARCHAR (30)    NULL,
    [NED_PATIENT_MIDDLE_NAME]        VARCHAR (25)    NULL,
    [MEDICAL_BENEFIT_INDICATOR]      VARCHAR (30)    NULL,
    [PRIMARY_CLINIC_IEN]             VARCHAR (15)    NULL,
    [DEERS_ELIGIBILITY_START_DATE]   DATETIME        NULL,
    [DEERS_ELIGIBILITY_END_DATE]     VARCHAR (30)    NULL,
    [DEERS_ELIGIBILITY]              VARCHAR (30)    NULL,
    [ACV_IEN]                        NUMERIC (21, 3) NULL,
    [DMIS_ID_IEN]                    NUMERIC (21, 3) NULL,
    [DDS]                            VARCHAR (30)    NULL,
    [DEERS_Override_Code_IEN]        NUMERIC (21, 3) NULL,
    [PERSON_ID]                      VARCHAR (30)    NULL,
    [DEERS_BENEFITS_ID]              VARCHAR (11)    NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_KEY_PATIENT]
    ON [dbo].[PATIENT]([KEY_PATIENT] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_NAME]
    ON [dbo].[PATIENT]([NAME] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_SSN]
    ON [dbo].[PATIENT]([SSN] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_SPONSOR_SSN]
    ON [dbo].[PATIENT]([SPONSOR_SSN] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_PROVIDER_IEN]
    ON [dbo].[PATIENT]([PROVIDER_IEN] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_FMP_IEN]
    ON [dbo].[PATIENT]([FMP_IEN] ASC) WITH (FILLFACTOR = 100);

