
create PROCEDURE [dbo].[procODS_CHCS_USER_SelectbyKey]
(
	@key numeric(12,4)
)
AS
	SET NOCOUNT ON;
	
SELECT 	
	CHCSUserId,
	CHCSUserKey, 
	CHCSUserName,
	ProviderId,
	TerminationDate,
	SSN,
	LastSignOn,
	CreatedDate,
	UpdatedDate
FROM
	CHCS_USER
WHERE 	
	(CHCSUserKey = @key)
