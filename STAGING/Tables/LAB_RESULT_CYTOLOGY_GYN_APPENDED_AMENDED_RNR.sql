﻿CREATE TABLE [dbo].[LAB_RESULT$CYTOLOGY_GYN$APPENDED_AMENDED_RNR] (
    [KEY_SITE]                                         NUMERIC (5)     NULL,
    [KEY_LAB_RESULT]                                   NUMERIC (13, 3) NULL,
    [KEY_LAB_RESULT$CYTOLOGY_GYN$APPENDED_AMENDED_RNR] NUMERIC (7, 3)  NULL,
    [KEY_LAB_RESULT$CYTOLOGY_GYN]                      NUMERIC (22, 7) NULL,
    [APPENDED_AMENDED_RNR_HCP_IEN]                     NUMERIC (22, 4) NULL,
    [APPENDED_AMENDED_RNR_DATE_TIME]                   DATETIME        NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ind_LAB_RESULT$CYTOLOGY_GYN$APPENDED_AMENDED_RNR]
    ON [dbo].[LAB_RESULT$CYTOLOGY_GYN$APPENDED_AMENDED_RNR]([KEY_SITE] ASC, [KEY_LAB_RESULT] ASC, [KEY_LAB_RESULT$CYTOLOGY_GYN$APPENDED_AMENDED_RNR] ASC, [KEY_LAB_RESULT$CYTOLOGY_GYN] ASC);
