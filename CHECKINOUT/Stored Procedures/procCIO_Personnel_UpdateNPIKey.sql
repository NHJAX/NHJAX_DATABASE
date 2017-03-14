create PROCEDURE [dbo].[procCIO_Personnel_UpdateNPIKey]
(
@pers bigint, 
@npi numeric(16,3),
@uby int
)
 AS

UPDATE PERSONNEL
SET NPIKey = @npi,
LBBy = @uby,
LBDate = getdate()
WHERE PersonnelId = @pers;



