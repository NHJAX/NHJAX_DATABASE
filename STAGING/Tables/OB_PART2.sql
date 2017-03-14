CREATE TABLE [dbo].[OB_PART2] (
    [KEY_ENCOUNTER]              DECIMAL (13, 3) NULL,
    [DATE_TIME]                  DATETIME2 (3)   NULL,
    [PATIENT_IEN]                DECIMAL (21, 3) NULL,
    [ADMISSION_DATE]             DATETIME2 (3)   NULL,
    [DISCHARGE_DATE]             DATETIME2 (3)   NULL,
    [DISCHARGE_DATE__FORMAT_]    VARCHAR (16)    NULL,
    [ADMISSION_DATE__FORMAT_]    VARCHAR (16)    NULL,
    [DRG_CODE]                   VARCHAR (30)    NULL,
    [TYPE_OF_ADMISSION]          VARCHAR (52)    NULL,
    [ENROLLING_DIVISION_DMIS_ID] VARCHAR (30)    NULL,
    [TYPE_OF_DISPOSITION]        VARCHAR (60)    NULL,
    [FMP_SSN]                    VARCHAR (15)    NULL,
    [BenefitsCategoryCode]       VARCHAR (30)    NULL,
    [BenefitsCategoryDesc]       VARCHAR (30)    NULL
);

