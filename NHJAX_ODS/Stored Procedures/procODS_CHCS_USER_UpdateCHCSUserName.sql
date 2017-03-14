
create PROCEDURE [dbo].[procODS_CHCS_USER_UpdateCHCSUserName]
(
	@name varchar(30),
	@key numeric(12,4)
)
AS
	SET NOCOUNT ON;
	
UPDATE CHCS_USER
SET CHCSUserName = @name,
	UpdatedDate = Getdate()
WHERE CHCSUserKey = @key;

