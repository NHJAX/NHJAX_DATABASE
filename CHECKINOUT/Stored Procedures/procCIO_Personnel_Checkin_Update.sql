CREATE PROCEDURE [dbo].[procCIO_Personnel_Checkin_Update]
(
@pck bigint, 
@stat int,
@uby int
)
 AS

UPDATE PERSONNEL_CHECKIN
SET CheckinStatusId = @stat,
UpdatedBy = @uby,
UpdatedDate = getdate()
WHERE PersonnelCheckinId = @pck;



