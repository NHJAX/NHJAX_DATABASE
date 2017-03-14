
CREATE PROCEDURE [dbo].[procENet_xxxInventoryRemove] 
AS
BEGIN
	

	SELECT   F1
	FROM  xxx20141024InventoryRADC
	WHERE Completed = 0
	ORDER BY F1


END