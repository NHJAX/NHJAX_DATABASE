-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION AudiencePersonnelCount
(
	@IncludeInActive bit=0, @AudienceId int=0, @IsADirectorate bit=0
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Return int=0

	IF @IncludeInActive = 1
		BEGIN
			IF @IsADirectorate = 1
				BEGIN
					SELECT @Return = COUNT(TECH.UserId) FROM TECHNICIAN AS TECH WHERE AudienceId IN (
						SELECT DEPT.AudienceId 
						FROM AUDIENCE as DEPT
						INNER JOIN AUDIENCE as DIR ON DEPT.ReportsUnder = DIR.AudienceId
						AND DIR.AudienceId = @AudienceId)
					AND LastFour <> '0000'
				END
			ELSE
				BEGIN
					SELECT @Return = COUNT(TECH.UserId) FROM TECHNICIAN AS TECH WHERE AudienceId = @AudienceId AND LastFour <> '0000'
				END				
		END
	ELSE
		BEGIN
			IF @IsADirectorate = 1
				BEGIN
					SELECT @Return = COUNT(TECH.UserId) FROM TECHNICIAN AS TECH 
					WHERE AudienceId IN (
						SELECT DEPT.AudienceId 
						FROM AUDIENCE as DEPT
						INNER JOIN AUDIENCE as DIR ON DEPT.ReportsUnder = DIR.AudienceId
						AND DIR.AudienceId = @AudienceId)
					AND TECH.Inactive = 0
					AND LastFour <> '0000'
				END
			ELSE
				BEGIN
					SELECT @Return = COUNT(TECH.UserId) FROM TECHNICIAN AS TECH WHERE AudienceId = @AudienceId AND TECH.Inactive = 0 AND LastFour <> '0000'
				END			
		END
	-- Return the result of the function
	RETURN @Return

END
