CREATE PROCEDURE [dbo].[procCIO_Personnel_Inprocess_Select]
(
@pers bigint
)
 AS

SELECT
	PersonnelInProcessId, 
	PersonnelId, 
	CheckInStepId, 
	InstructionsFor, 
	PersonnelTypeId, 
	SortOrder,
	CheckInStepDesc,
	SpecialInformation, 
	CreatedDate,
	CreatedBy,
	IsDefault,
	IsGroup,
	DesignationId,
	BaseId,
	CASE IsGroup
		WHEN 1 THEN SortOrder
		ELSE GroupSortOrder
	END AS GroupSortOrder
FROM	vwCIAO_PERSONNEL_INPROCESS_InstructionsFor
WHERE PersonnelId = @pers
ORDER BY GroupSortOrder,
	SortOrder, 
	InstructionsFor, 
	CheckInStepDesc,
	PersonnelTypeId;


