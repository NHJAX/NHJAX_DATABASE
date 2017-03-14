﻿CREATE VIEW [dbo].[vwProviderActivity]
AS
SELECT     SURGEON_IEN AS PROVIDER_IEN
FROM         ENCOUNTER$ICD_OPERATIONS_PROCEDURES
WHERE     (DATE_TIME >= dbo.StartOfDay(DATEADD(d, - 30, GETDATE()))) AND(SURGEON_IEN IS NOT NULL)
UNION
SELECT     ANESTHESIOLOGIST_IEN AS PROVIDER_IEN
FROM         ENCOUNTER$ICD_OPERATIONS_PROCEDURES
WHERE     (DATE_TIME >= dbo.StartOfDay(DATEADD(d, - 30, GETDATE()))) AND (ANESTHESIOLOGIST_IEN IS NOT NULL)
UNION
SELECT     ORDERING_HCP_IEN AS PROVIDER_IEN
FROM         ORDER_
WHERE     ORDER_DATE_TIME >= dbo.StartOfDay(DATEADD(d, - 30, getdate()))
UNION
SELECT     PROVIDER_IEN AS PROVIDER_IEN
FROM         PATIENT_APPOINTMENT
WHERE     APPOINTMENT_DATE_TIME >= dbo.StartOfDay(DATEADD(d, - 30, getdate()))
UNION
SELECT PROVIDER_IEN
FROM ENCOUNTER
WHERE DATE_TIME >= dbo.StartOfDay(DATEADD(d,-30,getdate()))
UNION
SELECT     PRO.KEY_PROVIDER AS PROVIDER_IEN
FROM         USER_ USR INNER JOIN
                      PROVIDER PRO ON USR.PROVIDER_IEN = PRO.KEY_PROVIDER
WHERE     (USR.TERMINATION_DATE IS NULL) OR
                      (USR.TERMINATION_DATE > dbo.StartOfDay(GETDATE()))
UNION
SELECT PROVIDER_IEN
FROM PRESCRIPTION
WHERE LAST_FILL_DATE >= dbo.StartOfDay(DATEADD(d,-30,getdate()))
