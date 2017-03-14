CREATE PROCEDURE [dbo].[procCIO_CheckIn_Step_SelectDefaults]

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
AND IsDefault = 1;


