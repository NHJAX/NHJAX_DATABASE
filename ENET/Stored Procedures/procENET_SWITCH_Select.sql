
CREATE PROCEDURE [dbo].[procENET_SWITCH_Select]
(
	@inac bit 
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

IF @inac = 0
	BEGIN
		SELECT 
			SwitchId,
			SwitchDesc,
			BaseId,
			CreatedBy,
			Inactive
		FROM SWITCH
		WHERE Inactive = 0
		AND SwitchId > 0
	END
ELSE
	SELECT 
			SwitchId,
			SwitchDesc,
			BaseId,
			CreatedBy,
			Inactive
		FROM SWITCH
		WHERE SwitchId > 0

END

