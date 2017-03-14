
create PROCEDURE [dbo].[procODS_CHCS_USER_UpdateTerminationDate]
(
	@tdate datetime,
	@key numeric(12,4)
)
AS
	SET NOCOUNT ON;

IF @tdate < '7/4/1776'
BEGIN
	UPDATE CHCS_USER
	SET TerminationDate = null,
		UpdatedDate = GETDATE()
	WHERE CHCSUserKey = @key;
END
ELSE
BEGIN
	UPDATE CHCS_USER
	SET TerminationDate = @tdate,
		UpdatedDate = Getdate()
	WHERE CHCSUserKey = @key;
END

