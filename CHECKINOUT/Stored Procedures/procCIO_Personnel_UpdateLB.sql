create PROCEDURE [dbo].[procCIO_Personnel_UpdateLB]
(
@pers bigint, 
@lb bit,
@uby int
)
 AS

UPDATE PERSONNEL
SET LB = @lb,
LBBy = @uby,
LBDate = getdate()
WHERE PersonnelId = @pers;



