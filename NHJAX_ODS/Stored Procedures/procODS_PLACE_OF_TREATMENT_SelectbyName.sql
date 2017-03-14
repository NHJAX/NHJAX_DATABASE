
create PROCEDURE [dbo].[procODS_PLACE_OF_TREATMENT_SelectbyName]
(
	@desc varchar(50)
)
AS
	SET NOCOUNT ON;
SELECT 	
	PlaceofTreatmentId,
	PlaceofTreatmentDesc,
	CreatedDate
FROM
	PLACE_OF_TREATMENT 
WHERE 	
	(PlaceofTreatmentDesc = @desc)
