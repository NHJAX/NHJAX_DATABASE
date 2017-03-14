CREATE PROCEDURE [dbo].[procCIO_CheckIn_Preference_Update]
(
	@bas int,
	@desg int,
	@pref int,
	@val varchar(50),
	@uby int
)
 AS

UPDATE CHECKIN_PREFERENCE
SET
PreferenceValue = @val,
UpdatedBy = @uby,
UpdatedDate = getdate()
WHERE BaseId = @bas
AND DesignationId = @desg
AND PreferenceId = @pref;


