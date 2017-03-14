create PROCEDURE [dbo].[procCIO_Personnel_Special_Software_Delete]
(
@pers bigint
)
 AS

DELETE FROM PERSONNEL_SPECIAL_SOFTWARE
WHERE PersonnelId = @pers;



