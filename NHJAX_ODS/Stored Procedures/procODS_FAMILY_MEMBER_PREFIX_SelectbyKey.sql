
create PROCEDURE [dbo].[procODS_FAMILY_MEMBER_PREFIX_SelectbyKey]
(
	@key numeric(8,3)
)
AS
	SET NOCOUNT ON;
SELECT 	
	FamilyMemberPrefixId,
	FamilyMemberPrefixKey, 
	FamilyMemberPrefixNumber,
	FamilyMemberPrefixCode,
	FamilyMemberPrefixDesc,
	CreatedDate,
	UpdatedDate
FROM
	FAMILY_MEMBER_PREFIX
WHERE 	
	(FamilyMemberPrefixKey = @key)
