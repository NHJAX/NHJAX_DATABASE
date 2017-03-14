
create PROCEDURE [dbo].[procENET_SWITCH_SelectbyBase]
(
	@bas int 
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

IF @bas > 0
	BEGIN
		SELECT 
			SwitchId,
			SwitchDesc,
			BaseId,
			CreatedBy,
			Inactive
		FROM SWITCH
		WHERE BaseId = @bas
		AND Inactive = 0
	END
ELSE
	SELECT 
			SwitchId,
			SwitchDesc,
			BaseId,
			CreatedBy,
			Inactive
		FROM SWITCH
		WHERE BaseId = 1
		AND Inactive = 0
END

