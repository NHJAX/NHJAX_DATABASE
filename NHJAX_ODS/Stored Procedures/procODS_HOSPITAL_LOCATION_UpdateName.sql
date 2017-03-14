
create PROCEDURE [dbo].[procODS_HOSPITAL_LOCATION_UpdateName]
(
	@key numeric(12,4),
	@name varchar(36)
)
AS
	SET NOCOUNT ON;
	
UPDATE HOSPITAL_LOCATION
SET HospitalLocationName = @name,
	UpdatedDate = Getdate()
WHERE HospitalLocationKey = @key;

