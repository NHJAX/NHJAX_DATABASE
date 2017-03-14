
CREATE PROCEDURE [dbo].[procENET_SYSTEM_TYPE_Update]
(
	@sys int,
	@desc nvarchar(50),
	@uby int,
	@isburn bit,
	@isman bit,
	@isproc bit,
	@dndisp bit,
	@inac bit,
	@notes nvarchar(max),
	@own int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

UPDATE SYSTEM_TYPE
	SET SystemDesc = @desc,
	IsBurndown =@isburn,
	IsManagedSystem =@isman,
	IsProcessOnly =@isproc,
	DoNotDisplay =@dndisp,
	Notes =@notes,
	Inactive =@inac,
	SystemOwnerId = @own,
	UpdatedBy=@uby	
WHERE SystemId = @sys
END

