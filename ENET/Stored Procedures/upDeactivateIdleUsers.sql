CREATE PROCEDURE [dbo].[upDeactivateIdleUsers] AS

UPDATE TECHNICIAN
SET 	
	Inactive = 1,
	UpdatedDate = getdate(),
	UpdatedBy = 0
WHERE
	DATEDIFF(d,UpdatedDate,getdate()) > 367
	AND Inactive = 0
