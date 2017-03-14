create PROCEDURE [dbo].[procCIAO_CHECKLIST_SelectbyId]
(
	@lst int
)
 AS

SELECT
	ChecklistId, 
	ChecklistDesc, 
	CreatedDate, 
	Inactive
FROM CHECKLIST
WHERE ChecklistId = @lst;


