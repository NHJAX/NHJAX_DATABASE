create PROCEDURE [dbo].[procCIO_CheckIn_Parameters_SelectChange]
(
@desg int, 
@bas int,
@pers bigint
)
 AS

SELECT
	STEP.CheckInStepId, 
	STEP.CheckInStepDesc, 
	STEP.Inactive, 
	STEP.IsDefault, 
	CAST(0 AS bigint) AS InstructionsFor, 
	STEP.PersonnelTypeId, 
	PRAM.SpecialInformation, 
	PRAM.DefaultSortOrder,
	0 as GroupOrder,
	PRAM.IsGroup,
	PRAM.DesignationId,
	PRAM.BaseId
FROM	CHECKIN_PARAMETER AS PRAM 
	INNER JOIN CHECKIN_STEP AS STEP 
	ON PRAM.CheckInStepId = STEP.CheckInStepId
WHERE PRAM.CheckInTypeId = 1
	AND (PRAM.BaseId = @bas) 
	AND (PRAM.DesignationId = @desg)
	AND (STEP.PersonnelTypeId = 0 
	OR STEP.PersonnelTypeId IN (SELECT PersonnelTypeId
	FROM PERSONNEL_TYPE_LIST WHERE PersonnelId = @pers))
AND PRAM.IsGroup = 1
ORDER BY PRAM.DefaultSortOrder, 
	STEP.InstructionsFor, 
	STEP.CheckInStepDesc,
	STEP.PersonnelTypeId;


