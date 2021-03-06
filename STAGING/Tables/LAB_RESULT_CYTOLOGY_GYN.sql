﻿CREATE TABLE [dbo].[LAB_RESULT$CYTOLOGY_GYN] (
    [KEY_SITE]                    NUMERIC (5)     NULL,
    [KEY_LAB_RESULT]              NUMERIC (13, 3) NULL,
    [KEY_LAB_RESULT$CYTOLOGY_GYN] NUMERIC (26, 9) NULL,
    [DATE_TIME_SPECIMEN_RECEIVED] DATETIME        NULL,
    [REQUESTING_LOCATION_IEN]     NUMERIC (22, 4) NULL,
    [ACCESSION_NUMBER]            VARCHAR (30)    NULL,
    [ENTER_PERSON_IEN]            NUMERIC (21, 3) NULL,
    [ENTER_DATE_TIME]             DATETIME        NULL,
    [RNR_HCP_IEN]                 NUMERIC (22, 4) NULL,
    [RNR_DATE_TIME]               DATETIME        NULL,
    [LAB_WORK_ELEMENT_IEN]        NUMERIC (21, 3) NULL,
    [LOG_IN_PERSON_IEN]           NUMERIC (21, 3) NULL,
    [REQUESTING_HCP_IEN]          NUMERIC (21, 3) NULL,
    [CERTIFY_DATE_TIME]           DATETIME        NULL,
    [ORDER_REFERENCE_IEN]         NUMERIC (21, 3) NULL,
    [ORDER_TASK_IEN]              NUMERIC (21, 3) NULL,
    [CERTIFY_PERSON_IEN]          NUMERIC (21, 3) NULL,
    [RESULT_COMMENT]              TEXT            NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ind_LAB_RESULT$CYTOLOGY_GYN]
    ON [dbo].[LAB_RESULT$CYTOLOGY_GYN]([KEY_SITE] ASC, [KEY_LAB_RESULT] ASC, [KEY_LAB_RESULT$CYTOLOGY_GYN] ASC);

