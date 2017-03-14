create PROCEDURE [dbo].[procCIO_Personnel_UpdatePSQ]
(
@pers bigint, 
@psq bit,
@uby int
)
 AS

UPDATE PERSONNEL
SET PSQ = @psq,
PSQBy = @uby,
PSQDate = getdate()
WHERE PersonnelId = @pers;



