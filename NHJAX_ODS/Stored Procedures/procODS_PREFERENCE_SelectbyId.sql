

create PROCEDURE [dbo].[procODS_PREFERENCE_SelectbyId]
	@pref int
AS
BEGIN
	
	SET NOCOUNT ON;

    SELECT PreferenceValue
    FROM PREFERENCE
	WHERE PreferenceId = @pref
END


