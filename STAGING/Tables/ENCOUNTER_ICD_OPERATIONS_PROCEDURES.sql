﻿CREATE TABLE [dbo].[ENCOUNTER$ICD_OPERATIONS_PROCEDURES] (
    [KEY_SITE]                                NUMERIC (5)     NULL,
    [KEY_ENCOUNTER]                           NUMERIC (13, 3) NULL,
    [KEY_ENCOUNTER$ICD_OPERATIONS_PROCEDURES] NUMERIC (8, 3)  NULL,
    [NUMBER_]                                 NUMERIC (13, 3) NULL,
    [ICD_OPERATIONS_PROCEDURES_IEN]           NUMERIC (21, 3) NULL,
    [DATE_TIME]                               DATETIME        NULL,
    [SURGEON_IEN]                             NUMERIC (21, 3) NULL,
    [ANESTHESIOLOGIST_IEN]                    NUMERIC (21, 3) NULL
);


GO
CREATE CLUSTERED INDEX [IX_ENCOUNTER$ICD_OPERATIONS_PROCEDURES_DATE_TIME]
    ON [dbo].[ENCOUNTER$ICD_OPERATIONS_PROCEDURES]([DATE_TIME] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_ENCOUNTER$ICD_OPERATIONS_PROCEDURES_KEY_ENCOUNTER$ICD_OPERATIONS_PROCEDURES]
    ON [dbo].[ENCOUNTER$ICD_OPERATIONS_PROCEDURES]([KEY_ENCOUNTER$ICD_OPERATIONS_PROCEDURES] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_ENCOUNTER$ICD_OPERATIONS_PROCEDURES_KEY_ENCOUNTER]
    ON [dbo].[ENCOUNTER$ICD_OPERATIONS_PROCEDURES]([KEY_ENCOUNTER] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_ENCOUNTER$ICD_OPERATIONS_PROCEDURES_NUMBER_]
    ON [dbo].[ENCOUNTER$ICD_OPERATIONS_PROCEDURES]([NUMBER_] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_ENCOUNTER$ICD_OPERATIONS_PROCEDURES_ICD_OPERATIONS_PROCEDURES_IEN]
    ON [dbo].[ENCOUNTER$ICD_OPERATIONS_PROCEDURES]([ICD_OPERATIONS_PROCEDURES_IEN] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_ENCOUNTER$ICD_OPERATIONS_PROCEDURES_SURGEON_IEN]
    ON [dbo].[ENCOUNTER$ICD_OPERATIONS_PROCEDURES]([SURGEON_IEN] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_ENCOUNTER$ICD_OPERATIONS_PROCEDURES_ANESTHESIOLOGIST_IEN]
    ON [dbo].[ENCOUNTER$ICD_OPERATIONS_PROCEDURES]([ANESTHESIOLOGIST_IEN] ASC) WITH (FILLFACTOR = 100);

