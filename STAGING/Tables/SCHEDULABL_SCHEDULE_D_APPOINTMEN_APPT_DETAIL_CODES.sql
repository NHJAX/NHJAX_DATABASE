﻿CREATE TABLE [dbo].[SCHEDULABL$SCHEDULE_D$APPOINTMEN$APPT_DETAIL_CODES] (
    [KEY_SITE]                                           NUMERIC (5)     NULL,
    [KEY_SCHEDULABLE_ENTITY]                             NUMERIC (11, 3) NULL,
    [KEY_SCHEDULABL$SCHEDULE_D$APPOINTMEN$APPT_DETAIL_C] NUMERIC (7, 3)  NULL,
    [KEY_SCHEDULABLE_ENT$SCHEDULE_DATE_T$APPOINTMENT_SL] NUMERIC (7, 3)  NULL,
    [KEY_SCHEDULABLE_ENTITY$SCHEDULE_DATE_TIMES]         NUMERIC (22, 7) NULL,
    [APPT_DETAIL_CODES_IEN]                              NUMERIC (21, 3) NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_SCHEDULABL$SCHEDULE_D$APPOINTMEN$APPT_DETAIL_CODES_KEY_SCHEDULABL$SCHEDULE_D$APPOINTMEN$APPT_DETAIL_C]
    ON [dbo].[SCHEDULABL$SCHEDULE_D$APPOINTMEN$APPT_DETAIL_CODES]([KEY_SCHEDULABL$SCHEDULE_D$APPOINTMEN$APPT_DETAIL_C] ASC) WITH (FILLFACTOR = 100);

