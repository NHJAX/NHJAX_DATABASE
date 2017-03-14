CREATE PROCEDURE [dbo].[procENET_Audience_Member_SelectAlternateLeaveRouting]

 AS

SELECT      
	GRP.AudienceId,
	AUD.DisplayName
FROM AUDIENCE_GROUP AS GRP 
	INNER JOIN AUDIENCE AS AUD 
	ON GRP.AudienceId = AUD.AudienceId
WHERE (GRP.GroupId = 29) 
	AND (GRP.IsLeaveAlternate = 1)
