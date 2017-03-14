create PROCEDURE [dbo].[procCIO_Personnel_Inprocess_SelectMaxSort]
(
@pers bigint
)
 AS

SELECT
	IsNull(Max(SortOrder),0)
FROM	PERSONNEL_INPROCESS 
WHERE (PersonnelId = @pers);


