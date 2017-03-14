
CREATE FUNCTION [dbo].[ReturnFMPCode](@fmp bigint)
RETURNS varchar(30) AS  
BEGIN 
	
	DECLARE @cd varchar(30)
	SELECT @cd = FamilyMemberPrefixCode
	FROM FAMILY_MEMBER_PREFIX
	WHERE FamilyMemberPrefixId = @fmp

	return @cd;
END

