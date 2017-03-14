CREATE PROCEDURE [dbo].[procCIO_CheckIn_Parameters_SelectMaxSort]
(
@desg int, 
@bas int
)
 AS

SELECT
	IsNull(Max(DefaultSortOrder),0)
FROM	CHECKIN_PARAMETER 
WHERE (BaseId = @bas) 
	AND (DesignationId = @desg)
	AND CheckinTypeId = 1;


