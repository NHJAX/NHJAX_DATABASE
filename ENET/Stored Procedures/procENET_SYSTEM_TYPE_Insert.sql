
CREATE PROCEDURE [dbo].[procENET_SYSTEM_TYPE_Insert]
(
	@desc nvarchar(50),
	@cby int,
	@isburn bit,
	@isman bit,
	@isproc bit,
	@dndisp bit,
	@notes nvarchar(max),
	@own int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

INSERT INTO SYSTEM_TYPE
( 
	SystemDesc,
	IsBurndown,
	IsManagedSystem,
	IsProcessOnly,
	DoNotDisplay,
	Notes,
	SystemOwnerId,
	CreatedBy,
	UpdatedBy
)
VALUES
(
	@desc,
	@isburn,
	@isman,
	@isproc,
	@dndisp,
	@notes,
	@own,
	@cby,
	@cby
);
SELECT SCOPE_IDENTITY()
END

