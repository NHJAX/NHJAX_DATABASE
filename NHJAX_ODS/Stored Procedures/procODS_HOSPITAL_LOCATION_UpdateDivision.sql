
create PROCEDURE [dbo].[procODS_HOSPITAL_LOCATION_UpdateDivision]
(
	@key numeric(12,4),
	@div bigint
)
AS
	SET NOCOUNT ON;
	
UPDATE HOSPITAL_LOCATION
SET MedicalCenterDivisionId = @div,
	UpdatedDate = Getdate()
WHERE HospitalLocationKey = @key;

