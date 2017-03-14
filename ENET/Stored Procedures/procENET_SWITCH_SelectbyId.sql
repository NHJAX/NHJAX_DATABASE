
create PROCEDURE [dbo].[procENET_SWITCH_SelectbyId]
(
	@swtch int 
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	SELECT 
			SwitchId,
			SwitchDesc,
			BaseId,
			CreatedBy,
			Inactive
		FROM SWITCH
		WHERE SwitchId = @swtch
END

