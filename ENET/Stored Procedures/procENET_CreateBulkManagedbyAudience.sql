CREATE PROCEDURE [dbo].[procENET_CreateBulkManagedbyAudience] 
(
	@usr		int = 814,
	@stat 		int = 0,
	@aud		bigint = 30,
	@sess		varchar(50) = 'xyz'
)

AS
SET NOCOUNT ON;

--DELETE ANY CURRENT SESSION DATA
BEGIN

DELETE FROM DM_BULK_TICKET_PRINT
WHERE SessionKey = @sess
OR DMCreatedDate < dbo.startofday(DATEADD(d,-3,getdate())) 

IF @stat = 0
BEGIN
	INSERT INTO DM_BULK_TICKET_PRINT
	(
		SessionKey, 
		TicketNumber, 
		TicketId, 
		TicketLocation, 
		SystemDesc, 
		ProblemTypeDesc, 
		PatientImpact, 
		UserAlpha, 
		CreatedDate, 
		AudienceDesc, 
		OrgChartCode, 
		UserPhone, 
		UserExtension, 
		AsgPhone, 
		AsgExtension, 
		ClsPhone, 
		ClsExtension, 
		PlantAccountNumber, 
		AssignedTo, 
		UserTitle, 
		UserEMail,
		UserAudienceDesc, 
		UserOrgChartCode, 
		UserLocation, 
		CreatedFor, 
		AsgClosedDate, 
		AssignedDate, 
		Comments, 
		AsgAlpha, 
		AsgEMail, 
		ClsAlpha, 
		ClsEMail,
		StatusId,
		Remarks,
		OpenDate,
		DisplayName,
		UserDisplayName,
		PriorityId,
		SoftwareDesc
	)
	SELECT @sess AS SessionKey,
		T.TicketNumber, 
		T.TicketId, 
		T.TicketLocation, 
		S.SystemDesc, 
		P.ProblemTypeDesc, 
		CASE T.PatientImpact 
		WHEN 1 THEN 'YES' 
		ELSE 'NO' END AS PatientImpact, 
		RTRIM(TECH.ULName) + ', ' + RTRIM(TECH.UFName) + ' ' + RTRIM(TECH.UMName) AS UserAlpha, 
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
		RTRIM(TECH2.ULName) + ', ' + RTRIM(TECH2.UFName) + ' ' + RTRIM(TECH2.UMName) AS AsgAlpha,  
		TECH2.EMailAddress AS AEMail,
		RTRIM(TECH3.ULName) + ', ' + RTRIM(TECH3.UFName) + ' ' + RTRIM(TECH3.UMName) AS ClsAlpha,  
		TECH3.EMailAddress AS CEMail, 
		T.StatusId, 
		TA2.Remarks, 
		T.OpenDate, 
		AUD.DisplayName, 
		TECHAUD.DisplayName,
		T.PriorityId,
		SOFT.SoftwareDesc
	FROM PROBLEM_TYPE P 
		INNER JOIN TICKET T 
		INNER JOIN TECHNICIAN TECH 
		ON T.CreatedFor = TECH.UserId 
		ON P.ProblemTypeId = T.ProblemTypeId 
		INNER JOIN SYSTEM_TYPE S 
		ON T.SystemNameId = S.SystemId 
		INNER JOIN AUDIENCE AUD 
		ON T.AudienceId = AUD.AudienceId 
		LEFT OUTER JOIN AUDIENCE TECHAUD 
		ON TECH.AudienceId = TECHAUD.AudienceId 
		LEFT OUTER JOIN vwCurrentAssignment VCA 
		INNER JOIN TICKET_ASSIGNMENT TA 
		ON VCA.TicketId = TA.TicketId 
		AND VCA.CurrentAssignment = TA.AssignmentDate 
		INNER JOIN TECHNICIAN TECH2 
		ON TA.AssignedTo = TECH2.UserId 
		ON T.TicketId = TA.TicketId 
		LEFT OUTER JOIN TECHNICIAN TECH3 
		ON TA.ClosedBy = TECH3.UserId 
		INNER JOIN TICKET_ASSIGNMENT AS TA2 
		ON TA.TicketId = TA2.TicketId
		INNER JOIN SOFTWARE_NAME AS SOFT
		ON T.SoftwareId = SOFT.SoftwareId
	WHERE T.AudienceId = @aud
		AND TA.AssignedTo = @usr
		AND T.StatusId < 3 AND TA.StatusId < 3
	ORDER BY T.PriorityId, T.OpenDate
END
ELSE
BEGIN
	INSERT INTO DM_BULK_TICKET_PRINT
	(
		SessionKey, 
		TicketNumber, 
		TicketId, 
		TicketLocation, 
		SystemDesc, 
		ProblemTypeDesc, 
		PatientImpact, 
		UserAlpha, 
		CreatedDate, 
		AudienceDesc, 
		OrgChartCode, 
		UserPhone, 
		UserExtension, 
		AsgPhone, 
		AsgExtension, 
		ClsPhone, 
		ClsExtension, 
		PlantAccountNumber, 
		AssignedTo, 
		UserTitle, 
		UserEMail,
		UserAudienceDesc, 
		UserOrgChartCode, 
		UserLocation, 
		CreatedFor, 
		AsgClosedDate, 
		AssignedDate, 
		Comments, 
		AsgAlpha, 
		AsgEMail, 
		ClsAlpha, 
		ClsEMail,
		StatusId,
		Remarks,
		OpenDate,
		DisplayName,
		UserDisplayName,
		PriorityId,
		SoftwareDesc
	)
	SELECT @sess AS SessionKey,
		T.TicketNumber, 
		T.TicketId, 
		T.TicketLocation, 
		S.SystemDesc, 
		P.ProblemTypeDesc, 
		CASE T.PatientImpact 
		WHEN 1 THEN 'YES' 
		ELSE 'NO' END AS PatientImpact, 
		RTRIM(TECH.ULName) + ', ' + RTRIM(TECH.UFName) + ' ' + RTRIM(TECH.UMName) AS UserAlpha, 
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
		RTRIM(TECH2.ULName) + ', ' + RTRIM(TECH2.UFName) + ' ' + RTRIM(TECH2.UMName) AS AsgAlpha,  
		TECH2.EMailAddress AS AEMail,
		RTRIM(TECH3.ULName) + ', ' + RTRIM(TECH3.UFName) + ' ' + RTRIM(TECH3.UMName) AS ClsAlpha,  
		TECH3.EMailAddress AS CEMail, 
		T.StatusId, 
		TA2.Remarks, 
		T.OpenDate, 
		AUD.DisplayName, 
		TECHAUD.DisplayName,
		T.PriorityId,
		SOFT.SoftwareDesc
	FROM PROBLEM_TYPE P 
		INNER JOIN TICKET T 
		INNER JOIN TECHNICIAN TECH 
		ON T.CreatedFor = TECH.UserId 
		ON P.ProblemTypeId = T.ProblemTypeId 
		INNER JOIN SYSTEM_TYPE S 
		ON T.SystemNameId = S.SystemId 
		INNER JOIN AUDIENCE AUD 
		ON T.AudienceId = AUD.AudienceId 
		LEFT OUTER JOIN AUDIENCE TECHAUD 
		ON TECH.AudienceId = TECHAUD.AudienceId 
		LEFT OUTER JOIN vwCurrentAssignment VCA 
		INNER JOIN TICKET_ASSIGNMENT TA 
		ON VCA.TicketId = TA.TicketId 
		AND VCA.CurrentAssignment = TA.AssignmentDate 
		INNER JOIN TECHNICIAN TECH2 
		ON TA.AssignedTo = TECH2.UserId 
		ON T.TicketId = TA.TicketId 
		LEFT OUTER JOIN TECHNICIAN TECH3 
		ON TA.ClosedBy = TECH3.UserId 
		INNER JOIN TICKET_ASSIGNMENT AS TA2 
		ON TA.TicketId = TA2.TicketId
		INNER JOIN SOFTWARE_NAME AS SOFT
		ON T.SoftwareId = SOFT.SoftwareId
	WHERE T.AudienceId = @aud
		AND TA.AssignedTo = @usr
	ORDER BY T.PriorityId, T.OpenDate
END


END

