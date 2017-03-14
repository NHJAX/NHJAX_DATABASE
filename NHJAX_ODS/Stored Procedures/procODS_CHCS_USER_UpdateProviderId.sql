
create PROCEDURE [dbo].[procODS_CHCS_USER_UpdateProviderId]
(
	@pro bigint,
	@key numeric(12,4)
)
AS
	SET NOCOUNT ON;

	UPDATE CHCS_USER
	SET ProviderId = @pro,
		UpdatedDate = Getdate()
	WHERE CHCSUserKey = @key;


