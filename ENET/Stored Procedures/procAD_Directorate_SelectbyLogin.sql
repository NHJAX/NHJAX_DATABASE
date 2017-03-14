CREATE PROCEDURE [dbo].[procAD_Directorate_SelectbyLogin]
(
	@login varchar(256)
)
AS

SELECT	
	AUD.AudienceId,
	AUD.AudienceDesc, 
	AUD.DisplayName
FROM	TECHNICIAN AS TECH 
	INNER JOIN vwENET_Audience_Directorate AS AD 
	ON TECH.AudienceId = AD.AudienceId 
	INNER JOIN AUDIENCE AS AUD 
	ON AD.DirectorateId = AUD.AudienceId
WHERE Tech.LoginId = @login






