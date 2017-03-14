create PROCEDURE [dbo].[procENET_Personnel_Special_Software_Delete]
(
@usr int
)
 AS

DELETE FROM PERSONNEL_SPECIAL_SOFTWARE
WHERE UserId = @usr;




