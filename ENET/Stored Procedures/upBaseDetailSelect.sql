CREATE PROCEDURE [dbo].[upBaseDetailSelect]
(
	@id int
)
AS

SELECT 
	BaseId,
	BaseName,
	SortOrder,
	Inactive,
	BaseCode
FROM BASE 
WHERE BaseId = @Id
