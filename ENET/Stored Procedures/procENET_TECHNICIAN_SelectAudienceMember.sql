CREATE PROCEDURE [dbo].[procENET_TECHNICIAN_SelectAudienceMember]
(
	@aud bigint
)
AS

SELECT  DISTINCT   
	Tech.UserId, 
	RTRIM(Tech.UFName) AS UFName, 
	RTRIM(Tech.ULName) AS ULName, 
	RTRIM(Tech.UMName) AS UMName,
	Tech.Suffix
FROM   TECHNICIAN Tech 
	INNER JOIN AUDIENCE_MEMBER MEM
	ON MEM.TechnicianId = Tech.UserId
WHERE MEM.AudienceId = @aud
ORDER BY Tech.ULName, Tech.UFName, Tech.UMName






