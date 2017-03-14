CREATE PROCEDURE [dbo].[procCIAO_CHECK_OUT_UpdateStatus]
(
	@co int,
	@stat int,
	@uby int
)
AS

BEGIN
UPDATE CHECK_OUT
SET CheckOutStatusId = @stat,
	UpdatedBy = @uby,
	UpdatedDate = GETDATE()
WHERE CheckOutId = @co

END