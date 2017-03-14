CREATE PROCEDURE [dbo].[procENET_Audience_Member_SelectEmailbyAudienceBillet]
(
	@aud bigint,
	@dept bigint
)
 AS

IF(@aud = 76)
BEGIN
SELECT DISTINCT EMailAddress
FROM vwENET_DIRECTORATE_EMAIL
WHERE AudienceId = @dept
END
ELSE
BEGIN
SELECT DISTINCT TECH.EMailAddress
FROM	AUDIENCE_MEMBER AS MEM 
	INNER JOIN TECHNICIAN AS TECH 
	ON MEM.TechnicianId = TECH.UserId 
	INNER JOIN AUDIENCE_BILLET AS BIL 
	ON MEM.BilletId = BIL.BilletId
WHERE     (DataLength(TECH.EMailAddress) > 0) 
	AND (BIL.AudienceId = @aud) 
	AND (MEM.AudienceId = @dept)
	AND (TECH.Inactive = 0)
	AND (TECH.Deployed = 0)
	AND (TECH.UserId NOT IN
		(
		SELECT UserId
		FROM TECHNICIAN_EXTENDED
		WHERE  (Deployed = 1) 
		AND (ReturnDate > GETDATE())
		)
		)
END

