CREATE PROCEDURE [dbo].[procCIAO_Checklist_Select]

 AS

SELECT
	ChecklistId, 
	ChecklistDesc, 
	CreatedDate, 
	Inactive
FROM CHECKLIST
WHERE ChecklistId > 0
AND Inactive = 0
AND IsCheckIn = 1
ORDER BY ChecklistDesc;


