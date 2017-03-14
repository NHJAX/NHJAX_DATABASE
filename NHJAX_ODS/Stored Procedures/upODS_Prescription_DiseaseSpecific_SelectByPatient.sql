
CREATE PROCEDURE [dbo].[upODS_Prescription_DiseaseSpecific_SelectByPatient]
(
	@dm bigint,
	@pat bigint
)
 AS

SELECT COUNT(
			PrescriptionId)
			FROM DISPENSING_EVENT

WHERE PatientId = @pat
	AND DiseaseManagementId = @dm