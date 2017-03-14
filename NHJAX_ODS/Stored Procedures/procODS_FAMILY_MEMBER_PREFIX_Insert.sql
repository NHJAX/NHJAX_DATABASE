
create PROCEDURE [dbo].[procODS_FAMILY_MEMBER_PREFIX_Insert]
(
	@key numeric(8,3),
	@num numeric(9,3),
	@cd varchar(30),
	@desc varchar(50)
)
AS
	SET NOCOUNT ON;
	
INSERT INTO NHJAX_ODS.dbo.FAMILY_MEMBER_PREFIX
(
	FamilyMemberPrefixKey,
	FamilyMemberPrefixNumber,
	FamilyMemberPrefixCode,
	FamilyMemberPrefixDesc
) 
VALUES
(
	@key, 
	@num,
	@cd,
	@desc
);
SELECT SCOPE_IDENTITY();