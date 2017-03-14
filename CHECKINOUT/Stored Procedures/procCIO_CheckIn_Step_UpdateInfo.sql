CREATE PROCEDURE [dbo].[procCIO_CheckIn_Step_UpdateInfo]
(
	@stp bigint,
	@info varchar(100),
	@strux bigint,
	@typ int,
	@uby int
)
 AS

UPDATE CHECKIN_STEP
SET SpecialInformation = @info,
InstructionsFor = @strux,
PersonnelTypeId = @typ,
UpdatedBy = @uby,
UpdatedDate = getdate()
WHERE CheckInStepId = @stp;


