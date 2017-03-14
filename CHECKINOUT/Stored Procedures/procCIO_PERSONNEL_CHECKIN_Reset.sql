create PROCEDURE [dbo].[procCIO_PERSONNEL_CHECKIN_Reset]
(
@psnl bigint
)
 AS

UPDATE PERSONNEL_CHECKIN
SET CheckinStatusId = 0,
UpdatedBy = 0,
UpdatedDate = GETDATE(),
CreatedDate = GETDATE()
WHERE PersonnelId = @psnl;



