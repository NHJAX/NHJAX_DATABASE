

CREATE PROCEDURE [dbo].[procODS_PREFERENCE_Update]
	@pref int,
	@val varchar(1000)
AS
BEGIN
	
	SET NOCOUNT ON;

    UPDATE PREFERENCE
	SET PreferenceValue = @val,
	UpdatedDate = GETDATE()
	WHERE PreferenceId = @pref
END


