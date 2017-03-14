
create PROCEDURE [dbo].[procODS_MEPRS_CODE_SelectbyLocation]
(
	@loc bigint
)
AS
	SET NOCOUNT ON;

SELECT     
	MEP.MeprsCodeId,
	MEP.MeprsCodeKey,
	MEP.MeprsCode,
	MEP.MeprsCodeDesc,    
	MEP.DmisId,
	MEP.CreatedDate,
	MEP.UpdatedDate
FROM MEPRS_CODE AS MEP
	INNER JOIN HOSPITAL_LOCATION 
	ON MEP.MeprsCodeId = HOSPITAL_LOCATION.MeprsCodeId
WHERE (HOSPITAL_LOCATION.HospitalLocationId = @loc)
