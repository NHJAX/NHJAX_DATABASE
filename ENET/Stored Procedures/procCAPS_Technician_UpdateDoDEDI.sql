CREATE PROCEDURE [dbo].[procCAPS_Technician_UpdateDoDEDI]
(
	@usr int,
	@dod nvarchar(10),
	@uby int
)
AS
UPDATE TECHNICIAN SET
	DoDEDI = @dod,
	UpdatedDate = GETDATE(),
	UpdatedBy = @uby
WHERE UserId = @usr;


