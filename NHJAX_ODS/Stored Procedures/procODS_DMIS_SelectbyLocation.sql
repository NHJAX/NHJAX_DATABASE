
create PROCEDURE [dbo].[procODS_DMIS_SelectbyLocation]
(
	@loc bigint
)
AS
	SET NOCOUNT ON;
SELECT     
	DMIS.DMISId, 
	DMIS.DMISKey, 
	DMIS.DMISCode, 
	DMIS.FacilityName, 
	DMIS.CreatedDate, 
	DMIS.UpdatedDate
FROM DMIS 
	INNER JOIN MEPRS_CODE 
	ON DMIS.DMISId = MEPRS_CODE.DmisId 
	INNER JOIN HOSPITAL_LOCATION 
	ON MEPRS_CODE.MeprsCodeId = HOSPITAL_LOCATION.MeprsCodeId
WHERE (HOSPITAL_LOCATION.HospitalLocationId = @loc)
