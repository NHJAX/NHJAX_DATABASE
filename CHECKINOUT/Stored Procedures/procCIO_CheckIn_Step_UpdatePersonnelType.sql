create PROCEDURE [dbo].[procCIO_CheckIn_Step_UpdatePersonnelType]
(
	@stp bigint,
	@typ int
)
 AS

UPDATE CHECKIN_STEP
SET
PersonnelTypeId = @typ
WHERE CheckInStepId = @stp;


