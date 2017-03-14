
CREATE PROCEDURE [dbo].[procODS_DMIS_UpdateFacilityName]
(
	@key numeric(10,3),
	@desc varchar(50)
)
AS
	SET NOCOUNT ON;
	
UPDATE DMIS
SET FacilityName = @desc,
	UpdatedDate = Getdate()
WHERE DmisKey = @key;

