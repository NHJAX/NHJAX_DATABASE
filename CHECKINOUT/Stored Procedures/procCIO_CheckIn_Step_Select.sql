CREATE PROCEDURE [dbo].[procCIO_CheckIn_Step_Select]

 AS

SELECT
	CheckInStepId, 
	CheckInStepDesc, 
	CreatedDate, 
	Inactive, 
	IsDefault, 
	InstructionsFor, 
	PersonnelTypeId, 
	SpecialInformation
FROM CHECKIN_STEP
WHERE CheckinStepId > 0
AND Inactive = 0
ORDER BY CheckInStepDesc;


