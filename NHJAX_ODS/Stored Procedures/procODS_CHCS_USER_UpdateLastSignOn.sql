
create PROCEDURE [dbo].[procODS_CHCS_USER_UpdateLastSignOn]
(
	@sigdt varchar(17),
	@key numeric(12,4)
)
AS
	SET NOCOUNT ON;

	UPDATE CHCS_USER
	SET LastSignOn = @sigdt,
		UpdatedDate = Getdate()
	WHERE CHCSUserKey = @key;


