
create PROCEDURE [dbo].[procODS_FAMILY_MEMBER_PREFIX_SelectbyCode]
(
	@cd varchar(30)
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
	(FamilyMemberPrefixCode = @cd)
