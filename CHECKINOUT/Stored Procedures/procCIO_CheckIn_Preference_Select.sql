create PROCEDURE [dbo].[procCIO_CheckIn_Preference_Select]
(
	@bas int,
	@desg int,
	@pref int
)
 AS

SELECT
	PreferenceValue 
FROM CHECKIN_PREFERENCE
WHERE BaseId = @bas
AND DesignationId = @desg 
AND PreferenceId = @pref



