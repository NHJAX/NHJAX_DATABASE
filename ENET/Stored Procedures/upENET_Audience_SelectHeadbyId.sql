CREATE PROCEDURE [dbo].[upENET_Audience_SelectHeadbyId]
(
	@aud bigint
)

 AS

SELECT DISTINCT 
	TECHNICIAN.UserId, 
	TECHNICIAN.UFName, 
	TECHNICIAN.ULName, 
	TECHNICIAN.UMName, 
	TECHNICIAN.EMailAddress, 
	BILLET.BilletShortName
FROM         
	AUDIENCE_MEMBER AS MEM 
	INNER JOIN TECHNICIAN 
	ON MEM.TechnicianId = TECHNICIAN.UserId 
	INNER JOIN BILLET 
	ON MEM.BilletId = BILLET.BilletId
WHERE     
	(MEM.BilletId IN (15, 17, 76, 77)) 
	AND (MEM.AudienceId = @aud)
	AND TECHNICIAN.Inactive = 0





