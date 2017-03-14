
create PROCEDURE [dbo].[procODS_HOSPITAL_LOCATION_UpdateDesc]
(
	@key numeric(12,4),
	@desc varchar(31)
)
AS
	SET NOCOUNT ON;
	
UPDATE HOSPITAL_LOCATION
SET HospitalLocationDesc = @desc,
	UpdatedDate = Getdate()
WHERE HospitalLocationKey = @key;

