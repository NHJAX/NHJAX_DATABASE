
create PROCEDURE [dbo].[procODS_HOSPITAL_LOCATION_UpdatePhone]
(
	@key numeric(12,4),
	@ph varchar(15)
)
AS
	SET NOCOUNT ON;
	
UPDATE HOSPITAL_LOCATION
SET GroupPhone = @ph,
	UpdatedDate = Getdate()
WHERE HospitalLocationKey = @key;

