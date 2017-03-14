﻿CREATE TABLE [dbo].[LAB_RESULT$CLINICAL_CHEMISTRY$RESULT] (
    [KEY_SITE]                                 NUMERIC (5)     NULL,
    [KEY_LAB_RESULT]                           NUMERIC (13, 3) NULL,
    [KEY_LAB_RESULT$CLINICAL_CHEMISTRY$RESULT] NUMERIC (10, 3) NULL,
    [KEY_LAB_RESULT$CLINICAL_CHEMISTRY]        NUMERIC (26, 9) NULL,
    [TEST_IEN]                                 NUMERIC (21, 3) NULL,
    [RESULT]                                   VARCHAR (39)    NULL,
    [RNR_HCP_IEN]                              NUMERIC (21, 3) NULL,
    [RNR_DATE_TIME]                            DATETIME        NULL,
    [ALERT]                                    VARCHAR (5)     NULL,
    [ENTER_DATE_TIME]                          DATETIME        NULL,
    [ENTER_PERSON_IEN]                         NUMERIC (27, 9) NULL,
    [CERTIFY_DATE_TIME]                        DATETIME        NULL,
    [CERTIFY_PERSON_IEN]                       NUMERIC (21, 3) NULL,
    [ORDER_TASK_IEN]                           NUMERIC (21, 3) NULL
);


GO
CREATE CLUSTERED INDEX [IX_LAB_RESULT$CLINICAL_CHEMISTRY$RESULT_ENTER_DATE_TIME]
    ON [dbo].[LAB_RESULT$CLINICAL_CHEMISTRY$RESULT]([ENTER_DATE_TIME] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_LAB_RESULT$CLINICAL_CHEMISTRY$RESULT_KEY_LAB_RESULT$CLINICAL_CHEMISTRY$RESULT]
    ON [dbo].[LAB_RESULT$CLINICAL_CHEMISTRY$RESULT]([KEY_LAB_RESULT$CLINICAL_CHEMISTRY$RESULT] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_LAB_RESULT$CLINICAL_CHEMISTRY$RESULT_KEY_LAB_RESULT$CLINICAL_CHEMISTRY]
    ON [dbo].[LAB_RESULT$CLINICAL_CHEMISTRY$RESULT]([KEY_LAB_RESULT$CLINICAL_CHEMISTRY] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_LAB_RESULT$CLINICAL_CHEMISTRY$RESULT_KEY_LAB_RESULT]
    ON [dbo].[LAB_RESULT$CLINICAL_CHEMISTRY$RESULT]([KEY_LAB_RESULT] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_LAB_RESULT$CLINICAL_CHEMISTRY$RESULT_MULTI_KEY]
    ON [dbo].[LAB_RESULT$CLINICAL_CHEMISTRY$RESULT]([KEY_LAB_RESULT] ASC, [KEY_LAB_RESULT$CLINICAL_CHEMISTRY] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_LAB_RESULT$CLINICAL_CHEMISTRY$RESULT_TEST_IEN]
    ON [dbo].[LAB_RESULT$CLINICAL_CHEMISTRY$RESULT]([TEST_IEN] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_LAB_RESULT$CLINICAL_CHEMISTRY$RESULT_ORDER_TASK_IEN]
    ON [dbo].[LAB_RESULT$CLINICAL_CHEMISTRY$RESULT]([ORDER_TASK_IEN] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_LAB_RESULT$CLINICAL_CHEMISTRY$RESULT_CERTIFY_DATE_TIME]
    ON [dbo].[LAB_RESULT$CLINICAL_CHEMISTRY$RESULT]([CERTIFY_DATE_TIME] ASC) WITH (FILLFACTOR = 100);
