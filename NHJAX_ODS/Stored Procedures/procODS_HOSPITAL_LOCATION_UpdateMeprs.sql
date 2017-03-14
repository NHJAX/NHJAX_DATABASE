
create PROCEDURE [dbo].[procODS_HOSPITAL_LOCATION_UpdateMeprs]
(
	@key numeric(12,4),
	@mep bigint
)
AS
	SET NOCOUNT ON;
	
UPDATE HOSPITAL_LOCATION
SET MeprsCodeId = @mep,
	UpdatedDate = Getdate()
WHERE HospitalLocationKey = @key;

