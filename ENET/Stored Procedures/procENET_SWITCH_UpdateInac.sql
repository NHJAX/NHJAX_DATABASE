
create PROCEDURE [dbo].[procENET_SWITCH_UpdateInac]
(
	@swtch int,
	@inac bit
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

UPDATE SWITCH
	SET 
	Inactive =@inac
WHERE SwitchId = @swtch
END

