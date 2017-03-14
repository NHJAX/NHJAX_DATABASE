
create PROCEDURE [dbo].[procODS_CHCS_USER_UpdateSSN]
(
	@ssn varchar(30),
	@key numeric(12,4)
)
AS
	SET NOCOUNT ON;

	UPDATE CHCS_USER
	SET SSN = @ssn,
		UpdatedDate = Getdate()
	WHERE CHCSUserKey = @key;


