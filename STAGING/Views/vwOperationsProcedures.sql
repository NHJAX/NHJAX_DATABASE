﻿CREATE VIEW [dbo].[vwOperationsProcedures]
AS
SELECT     dbo.ICD_OPERATION_PROCEDURE.DESCRIPTION, dbo.ENCOUNTER.TYPE_, dbo.ENCOUNTER.DATE_TIME, PROVIDER_1.NAME AS Assisting, 
                      dbo.PATIENT.NAME AS PatientName, dbo.PATIENT.SPONSOR_SSN, dbo.ICD_OPERATION_PROCEDURE.CODE_NUMBER, 
                      dbo.PROVIDER.NAME AS Surgeon, dbo.FAMILY_MEMBER_PREFIX.FMP
FROM         dbo.ENCOUNTER$ICD_OPERATIONS_PROCEDURES X INNER JOIN
                      dbo.ICD_OPERATION_PROCEDURE ON 
                      X.ICD_OPERATIONS_PROCEDURES_IEN = dbo.ICD_OPERATION_PROCEDURE.KEY_ICD_OPERATION_PROCEDURE INNER JOIN
                      dbo.ENCOUNTER ON X.KEY_ENCOUNTER = dbo.ENCOUNTER.KEY_ENCOUNTER INNER JOIN
                      dbo.PROVIDER ON X.SURGEON_IEN = dbo.PROVIDER.KEY_PROVIDER INNER JOIN
                      dbo.ENCOUNTER$ICD_OPERATIONS_PR$ASSISTING_HCPS ON 
                      dbo.ENCOUNTER.KEY_ENCOUNTER = dbo.ENCOUNTER$ICD_OPERATIONS_PR$ASSISTING_HCPS.KEY_ENCOUNTER INNER JOIN
                      dbo.PROVIDER PROVIDER_1 ON 
                      dbo.ENCOUNTER$ICD_OPERATIONS_PR$ASSISTING_HCPS.ASSISTING_HCPS_IEN = PROVIDER_1.KEY_PROVIDER INNER JOIN
                      dbo.PATIENT ON dbo.ENCOUNTER.PATIENT_IEN = dbo.PATIENT.KEY_PATIENT INNER JOIN
                      dbo.FAMILY_MEMBER_PREFIX ON dbo.PATIENT.FMP_IEN = dbo.FAMILY_MEMBER_PREFIX.KEY_FAMILY_MEMBER_PREFIX
