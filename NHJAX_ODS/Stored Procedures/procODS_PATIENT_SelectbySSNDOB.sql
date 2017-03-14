
CREATE PROCEDURE [dbo].[procODS_PATIENT_SelectbySSNDOB]
(
	@spon varchar(15),
	@dob datetime
)
AS
	SET NOCOUNT ON;
	
UPDATE GENERATOR SET LastNumber = LastNumber + 1
WHERE GeneratorTypeId = 1
	
SELECT     
	PatientId, dbo.GenerateEncounterKey(PatientId) As EncounterKey
FROM PATIENT
WHERE (SponsorSSN = dbo.FormattedSSN(@spon))
	AND DOB = @dob
