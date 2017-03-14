create PROCEDURE [dbo].[procCIAO_CheckOutlist_Select]

 AS

SELECT
	ChecklistId, 
	ChecklistDesc, 
	CreatedDate, 
	Inactive
FROM CHECKLIST
WHERE ChecklistId > 0
AND Inactive = 0
AND IsCheckIn = 0
ORDER BY ChecklistId;


