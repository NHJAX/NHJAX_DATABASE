﻿CREATE VIEW [dbo].[vwRecords]
AS
SELECT     R.*, dbo.ToRecordGroup(R.DAYS_CHARGED_TO_BORROWER) AS [Group], B.NAME AS CURRENT_BORROWER_FILE_ROOM, 
                      T.NAME AS TYPE_OF_RECORD, M.NAME AS TYPE_OF_MOVEMENT
FROM         dbo.RECORD_TYPES T INNER JOIN
                      dbo.RECORDS R ON T.KEY_RECORD_TYPES = R.TYPE_OF_RECORD_IEN INNER JOIN
                      dbo.RECORD_MOVEMENT_TYPES M ON R.TYPE_OF_MOVEMENT_IEN = M.KEY_RECORD_MOVEMENT_TYPES INNER JOIN
                      dbo.BORROWERS_FILE_AREAS B ON R.CURRENT_BORROWER_FILE_ROOM_IEN = B.KEY_BORROWERS_FILE_AREAS
WHERE     (M.NAME IN ('CHARGE-OUT', 'RE-CHARGE','CHECK-IN')) AND (B.NAME NOT IN ('3NE', '4SEMED', '5NE', '5SW', '6 WEST', '7 EAST', '7WEST', 'ANALYZER', 
                      'ANESTHESIOLOGY', 'BLANCO,JANICE D', 'CARDIOLOGY RESOURCE SHARING', 'CF AVIATION', 'CF AVIATION MED', 'CHARGE OUT TO PT', 'CODING', 
                      'CORRESPONDENCE CLERK', 'DICTATION', 'EMERGENCY ROOM', 'ER STAFF', 'FINALIZER', 'INFECTION CONTROL', 'INTERNAL MEDICINE', 
                      'JAX CLINIC RECORDS', 'JAX NAR MEDICAL RECORDS', 'LAB BLOOD BANK', 'LACTATION CLINIC', 'LEGAL', 'NPRC DEP/RET ST LOUIS, MO', 
                      'NPRC ST LOUIS MO', 'OBGYN', 'OBSTETRICS', 'OPD HOLD', 'ORTHOPEADICS', 'PATIENT ADMINISTRATION', 'PEER', 'PEER REVIEW ARCHIVES', 
                      'QA NAS', 'QUALITY ASSURANCE', 'RESPIRATORY THERAPHY', 'RESPIRATORY THERAPY', 'SAME DAY SURGERY', 'SEQUESTER', 
                      'ST LOUIS (RETIRED)', 'ORTHOPEDICS', 'SURGERY CLINIC', 'SURGICAL CLINIC', 'UNKNOWN LOCATION', 'WAREHOUSE', 'WAREHOUSE (706)', 
                      'WAREHOUSE (OFFSITE)', 'WHAREHOUSE')) AND (B.NAME NOT LIKE 'WAREHOUSE%')
