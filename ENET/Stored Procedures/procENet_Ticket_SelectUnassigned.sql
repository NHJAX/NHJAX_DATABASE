CREATE PROCEDURE [dbo].[procENet_Ticket_SelectUnassigned]

 AS

SELECT 
	T.TicketNumber, 
	T.TicketId, 
	T.TicketLocation, 
	S.SystemDesc, 
	P.ProblemTypeDesc, 
	CASE T.PatientImpact 
		WHEN 1 THEN 'YES' 
		ELSE 'NO' 
	END AS PatientImpact, 
	RTRIM(TECH.UFName) AS UFName, 
	RTRIM(TECH.UMName) AS UMName, 
	RTRIM(TECH.ULName) AS ULName, 
	T.CreatedDate, 
	AUD.AudienceDesc AS TicketAudienceDesc, 
	AUD.OrgChartCode AS TicketAudienceCode, 
	TECH.UPhone, 
	TECH.Extension, 
	TECH2.UPhone AS APhone, 
	TECH2.Extension, 
	TECH3.UPhone AS CPhone, 
	TECH3.Extension, 
	T.PlantAccountNum, 
	TA.AssignedTo, 
	TECH.Title AS UserTitle, 
	TECH.EMailAddress AS UserEMail, 
	TECHAUD.AudienceDesc AS UserAudienceDesc, 
	TECHAUD.OrgChartCode AS UserAudienceCode, 
	TECH.Location AS UserLocation, 
	T.CreatedFor, 
	TA.ClosedDate, 
	T.AssignedDate, 
	T.Comments, 
	RTRIM(TECH2.UFName) AS AFName, 
	RTRIM(TECH2.UMName) AS AMName, 
	RTRIM(TECH2.ULName) AS ALName, 
	TECH2.EMailAddress AS AEMail, 
	RTRIM(TECH3.UFName) AS CFName,
	RTRIM(TECH3.UMName) AS CMName, 
	RTRIM(TECH3.ULName) AS CLName, 
	TECH3.EMailAddress AS CEMail, 
	T.StatusId, 
	TA.Remarks, 
	T.OpenDate, 
	AUD.DisplayName, 
	TECHAUD.DisplayName,
	T.PatientImpact,
	T.ProblemTypeId,
	T.SystemNameId,
	T.SoftwareId,
	T.AudienceId,
	TA.TierId,
	TA.[Hours],
	TIER.TierDesc,
	T.CustomerName
FROM TIER 
	INNER JOIN vwCurrentAssignment AS VCA 
	INNER JOIN TICKET_ASSIGNMENT AS TA 
	ON VCA.TicketId = TA.TicketId 
	AND VCA.CurrentAssignment = TA.AssignmentDate 
	INNER JOIN TECHNICIAN AS TECH2 
	ON TA.AssignedTo = TECH2.UserId 
	ON TIER.TierId = TA.TierId 
	RIGHT OUTER JOIN PROBLEM_TYPE AS P 
	INNER JOIN TICKET AS T 
	INNER JOIN TECHNICIAN AS TECH 
	ON T.CreatedFor = TECH.UserId 
	ON P.ProblemTypeId = T.ProblemTypeId 
	INNER JOIN SYSTEM_TYPE AS S 
	ON T.SystemNameId = S.SystemId 
	INNER JOIN AUDIENCE AS AUD 
	ON T.AudienceId = AUD.AudienceId 
	LEFT OUTER JOIN AUDIENCE AS TECHAUD 
	ON TECH.AudienceId = TECHAUD.AudienceId 
	ON TA.TicketId = T.TicketId 
	LEFT OUTER JOIN TECHNICIAN AS TECH3 
	ON TA.ClosedBy = TECH3.UserId
	WHERE T.StatusId = 1 

