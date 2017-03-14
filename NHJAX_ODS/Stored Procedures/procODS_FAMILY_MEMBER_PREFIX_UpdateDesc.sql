
create PROCEDURE [dbo].[procODS_FAMILY_MEMBER_PREFIX_UpdateDesc]
(
	@key numeric(8,3),
	@desc varchar(50)
)
AS
	SET NOCOUNT ON;
	
UPDATE FAMILY_MEMBER_PREFIX
SET FamilyMemberPrefixDesc = @desc,
	UpdatedDate = Getdate()
WHERE FamilyMemberPrefixKey = @key;

