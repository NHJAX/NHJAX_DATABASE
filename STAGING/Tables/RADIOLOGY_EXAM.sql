﻿CREATE TABLE [dbo].[RADIOLOGY_EXAM] (
    [KEY_SITE]                  NUMERIC (5)     NULL,
    [KEY_RADIOLOGY_EXAM]        NUMERIC (15, 3) NULL,
    [EXAM_NO_]                  VARCHAR (8)     NULL,
    [NAME_IEN]                  NUMERIC (21, 3) NULL,
    [PROCEDURE_IEN]             NUMERIC (21, 3) NULL,
    [EXAM_STATUS_IEN]           NUMERIC (21, 3) NULL,
    [ORDER_TASK_NUMBER_IEN]     NUMERIC (21, 3) NULL,
    [ORDER_DATE_TIME]           DATETIME        NULL,
    [REQUESTING_HCP_IEN]        NUMERIC (21, 3) NULL,
    [EXAM_DATE_TIME]            DATETIME        NULL,
    [ARRIVAL_DATE_TIME]         DATETIME        NULL,
    [DEPARTURE_DATE_TIME]       VARCHAR (16)    NULL,
    [IMAGING_TYPE_IEN]          NUMERIC (21, 3) NULL,
    [REQUESTED_EXAM_DATE_TIME]  DATETIME        NULL,
    [SCHEDULED_DATE_TIME]       DATETIME        NULL,
    [REQ__WARD_CLINIC_IEN]      NUMERIC (22, 4) NULL,
    [REQ__LOCATION_CODE_IEN]    NUMERIC (21, 3) NULL,
    [PATIENT_MOBILITY_STATUS]   VARCHAR (30)    NULL,
    [PROCEDURE_START_DATE_TIME] VARCHAR (16)    NULL,
    [PROCEDURE_STOP_DATE_TIME]  VARCHAR (16)    NULL,
    [ABORT_DATE_TIME]           VARCHAR (16)    NULL,
    [PERFORMING_TECHNICIAN_IEN] NUMERIC (21, 3) NULL,
    [TOTAL_EXPOSURES]           NUMERIC (9, 3)  NULL,
    [DEPARTURE_STATUS_IEN]      NUMERIC (21, 3) NULL,
    [REFERENCE_DATE_TIME]       DATETIME        NULL,
    [SCHEDULE_DURATION]         NUMERIC (9, 3)  NULL,
    [PATIENT_APPT_IEN]          NUMERIC (21, 3) NULL,
    [PREP_DATE_TIME]            DATETIME        NULL,
    [DATE_EXAM_WAS_SCHEDULED]   DATETIME        NULL,
    [WAS_BARIUM_USED_]          VARCHAR (30)    NULL,
    [INTRAVASCULAR_CONTRAST]    VARCHAR (30)    NULL,
    [PORTABLE]                  VARCHAR (30)    NULL,
    [ORDER_IEN_IEN]             NUMERIC (21, 3) NULL
);


GO
CREATE CLUSTERED INDEX [IX_RADIOLOGY_EXAM_EXAM_DATE_TIME]
    ON [dbo].[RADIOLOGY_EXAM]([EXAM_DATE_TIME] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_RADIOLOGY_EXAM_KEY_RADIOLOGY_EXAM]
    ON [dbo].[RADIOLOGY_EXAM]([KEY_RADIOLOGY_EXAM] ASC) WITH (FILLFACTOR = 100);
