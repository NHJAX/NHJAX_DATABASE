CREATE PROCEDURE [dbo].[procCIO_CheckIn_Parameters_SelectTemplate]
(
@desg int, 
@bas int,
@pers bigint
)
 AS

IF @pers = 0
BEGIN
SELECT DISTINCT
	STEP.CheckInStepId, 
	STEP.CheckInStepDesc, 
	STEP.Inactive, 
	STEP.IsDefault, 
	PRAM.InstructionsFor, 
	STEP.PersonnelTypeId, 
	PRAM.SpecialInformation, 
	PRAM.DefaultSortOrder,
	PRAM.DefaultSortOrder AS GroupOrder,
	PRAM.IsGroup,
	PRAM.DesignationId,
	PRAM.BaseId
FROM	CHECKIN_PARAMETER AS PRAM 
	INNER JOIN CHECKIN_STEP AS STEP 
	ON PRAM.CheckInStepId = STEP.CheckInStepId
WHERE (PRAM.BaseId = @bas) 
	AND (PRAM.DesignationId = @desg)
	AND PRAM.CheckInTypeId = 1
	AND STEP.PersonnelTypeId = 0
	AND PRAM.InstructionsFor = 0
	
UNION
SELECT DISTINCT  
	STEP.CheckInStepId, 
	STEP.CheckInStepDesc, 
	STEP.Inactive, 
	STEP.IsDefault, 
	PRAM.InstructionsFor, 
	STEP.PersonnelTypeId, 
	PRAM.SpecialInformation, 
	GRP.DefaultSortOrder,
	PRAM.DefaultSortOrder AS GroupOrder,
	PRAM.IsGroup,
	PRAM.DesignationId,
	PRAM.BaseId
FROM	CHECKIN_PARAMETER AS PRAM 
	INNER JOIN CHECKIN_STEP AS STEP 
	ON PRAM.CheckInStepId = STEP.CheckInStepId
	INNER JOIN CHECKIN_PARAMETER AS GRP
	ON PRAM.InstructionsFor = GRP.CheckInStepId
	AND PRAM.BaseId = GRP.BaseId
	AND PRAM.DesignationId = GRP.DesignationId
WHERE (PRAM.BaseId = @bas) 
	AND (PRAM.DesignationId = @desg) 
	AND STEP.PersonnelTypeId = 0
	AND PRAM.CheckInTypeId = 1
	AND PRAM.InstructionsFor > 0

UNION
SELECT  DISTINCT  
	STEP.CheckInStepId, 
	STEP.CheckInStepDesc, 
	STEP.Inactive, 
	STEP.IsDefault, 
	PRAM.InstructionsFor, 
	STEP.PersonnelTypeId, 
	PRAM.SpecialInformation, 
	PRAM.DefaultSortOrder,
	PRAM.DefaultSortOrder AS GroupOrder,
	PRAM.IsGroup,
	PRAM.DesignationId,
	PRAM.BaseId
FROM	CHECKIN_PARAMETER AS PRAM 
	INNER JOIN CHECKIN_STEP AS STEP 
	ON PRAM.CheckInStepId = STEP.CheckInStepId
WHERE PRAM.CheckInTypeId = 1
	AND (PRAM.BaseId = @bas) 
	AND (PRAM.DesignationId = @desg)  
	AND STEP.PersonnelTypeId <> 0
	AND PRAM.InstructionsFor = 0
	AND STEP.PersonnelTypeId IN (SELECT PersonnelTypeId
	FROM vwENET_PERSONNEL_TYPE)
	
UNION
SELECT DISTINCT    
	STEP.CheckInStepId, 
	STEP.CheckInStepDesc, 
	STEP.Inactive, 
	STEP.IsDefault, 
	PRAM.InstructionsFor, 
	STEP.PersonnelTypeId, 
	PRAM.SpecialInformation, 
	GRP.DefaultSortOrder,
	PRAM.DefaultSortOrder AS GroupOrder,
	PRAM.IsGroup,
	PRAM.DesignationId,
	PRAM.BaseId
FROM	CHECKIN_PARAMETER AS PRAM 
	INNER JOIN CHECKIN_STEP AS STEP 
	ON PRAM.CheckInStepId = STEP.CheckInStepId
	INNER JOIN CHECKIN_PARAMETER AS GRP
	ON PRAM.InstructionsFor = GRP.CheckInStepId
	AND PRAM.BaseId = GRP.BaseId
	AND PRAM.DesignationId = GRP.DesignationId
WHERE PRAM.CheckInTypeId = 1
	AND (PRAM.BaseId = @bas) 
	AND (PRAM.DesignationId = @desg)  
	AND STEP.PersonnelTypeId <> 0
	AND PRAM.InstructionsFor > 0
	AND STEP.PersonnelTypeId IN (SELECT PersonnelTypeId
	FROM vwENET_PERSONNEL_TYPE)

ORDER BY 
	PRAM.DefaultSortOrder, 
	GroupOrder,
	PRAM.InstructionsFor, 
	STEP.CheckInStepDesc,
	STEP.PersonnelTypeId;
END

ELSE
BEGIN
SELECT DISTINCT
	STEP.CheckInStepId, 
	STEP.CheckInStepDesc, 
	STEP.Inactive, 
	STEP.IsDefault, 
	PRAM.InstructionsFor, 
	STEP.PersonnelTypeId, 
	PRAM.SpecialInformation, 
	PRAM.DefaultSortOrder,
	PRAM.DefaultSortOrder AS GroupOrder,
	PRAM.IsGroup,
	PRAM.DesignationId,
	PRAM.BaseId
FROM	CHECKIN_PARAMETER AS PRAM 
	INNER JOIN CHECKIN_STEP AS STEP 
	ON PRAM.CheckInStepId = STEP.CheckInStepId
WHERE (PRAM.BaseId = @bas) 
	AND (PRAM.DesignationId = @desg)
	AND PRAM.CheckInTypeId = 1
	AND STEP.PersonnelTypeId = 0
	AND PRAM.InstructionsFor = 0
	
UNION
SELECT  DISTINCT   
	STEP.CheckInStepId, 
	STEP.CheckInStepDesc, 
	STEP.Inactive, 
	STEP.IsDefault, 
	PRAM.InstructionsFor, 
	STEP.PersonnelTypeId, 
	PRAM.SpecialInformation, 
	GRP.DefaultSortOrder,
	PRAM.DefaultSortOrder AS GroupOrder,
	PRAM.IsGroup,
	PRAM.DesignationId,
	PRAM.BaseId
FROM	CHECKIN_PARAMETER AS PRAM 
	INNER JOIN CHECKIN_STEP AS STEP 
	ON PRAM.CheckInStepId = STEP.CheckInStepId
	INNER JOIN CHECKIN_PARAMETER AS GRP
	ON PRAM.InstructionsFor = GRP.CheckInStepId
	AND PRAM.BaseId = GRP.BaseId
	AND PRAM.DesignationId = GRP.DesignationId
WHERE (PRAM.BaseId = @bas) 
	AND (PRAM.DesignationId = @desg) 
	AND STEP.PersonnelTypeId = 0
	AND PRAM.CheckInTypeId = 1
	AND PRAM.InstructionsFor > 0

UNION
SELECT DISTINCT 
	STEP.CheckInStepId, 
	STEP.CheckInStepDesc, 
	STEP.Inactive, 
	STEP.IsDefault, 
	PRAM.InstructionsFor, 
	STEP.PersonnelTypeId, 
	PRAM.SpecialInformation, 
	PRAM.DefaultSortOrder,
	PRAM.DefaultSortOrder AS GroupOrder,
	PRAM.IsGroup,
	PRAM.DesignationId,
	PRAM.BaseId
FROM	CHECKIN_PARAMETER AS PRAM 
	INNER JOIN CHECKIN_STEP AS STEP 
	ON PRAM.CheckInStepId = STEP.CheckInStepId
WHERE PRAM.CheckInTypeId = 1
	AND (PRAM.BaseId = @bas) 
	AND (PRAM.DesignationId = @desg)  
	AND STEP.PersonnelTypeId <> 0
	AND PRAM.InstructionsFor = 0
	AND STEP.PersonnelTypeId IN (SELECT PersonnelTypeId
	FROM PERSONNEL_TYPE_LIST WHERE PersonnelId = @pers)
	
UNION
SELECT  DISTINCT   
	STEP.CheckInStepId, 
	STEP.CheckInStepDesc, 
	STEP.Inactive, 
	STEP.IsDefault, 
	PRAM.InstructionsFor, 
	STEP.PersonnelTypeId, 
	PRAM.SpecialInformation, 
	GRP.DefaultSortOrder,
	PRAM.DefaultSortOrder AS GroupOrder,
	PRAM.IsGroup,
	PRAM.DesignationId,
	PRAM.BaseId
FROM	CHECKIN_PARAMETER AS PRAM 
	INNER JOIN CHECKIN_STEP AS STEP 
	ON PRAM.CheckInStepId = STEP.CheckInStepId
	INNER JOIN CHECKIN_PARAMETER AS GRP
	ON PRAM.InstructionsFor = GRP.CheckInStepId
	AND PRAM.BaseId = GRP.BaseId
	AND PRAM.DesignationId = GRP.DesignationId
WHERE PRAM.CheckInTypeId = 1
	AND (PRAM.BaseId = @bas) 
	AND (PRAM.DesignationId = @desg)  
	AND STEP.PersonnelTypeId <> 0
	AND PRAM.InstructionsFor > 0
	AND STEP.PersonnelTypeId IN (SELECT PersonnelTypeId
	FROM PERSONNEL_TYPE_LIST WHERE PersonnelId = @pers)

ORDER BY 
	PRAM.DefaultSortOrder, 
	GroupOrder,
	PRAM.InstructionsFor, 
	STEP.CheckInStepDesc,
	STEP.PersonnelTypeId;


	


END


