CREATE PROCEDURE [dbo].[procENET_TICKET_FEEDBACK_SelectReport]
(
	@typ int = 0,
	@sdate datetime = '1/1/1900',
	@edate datetime = '12/31/2100',
	@tech int,
	@num varchar(50) = ' '
)
AS
BEGIN
	DECLARE @ucnt int
	
	SET @ucnt = dbo.CountTechList(@tech)
	
	--PRINT @tech
	--PRINT @ucnt
	--PRINT @typ
	--PRINT LEN(@num)
	
	
	IF LEN(@num) > 1
	BEGIN	
		SELECT DISTINCT 
			TF.CreatedDate,
			TF.Comments, 
			TKT.TicketNumber, 
			TF.CustomerSatisfied,
			ISNULL(TECH.ULName + ', ' + TECH.UFName + ' ' + TECH.UMName,'Anonymous') AS CreatedFor,
			AUD.DisplayName,
			ISNULL(TECH2.ULName + ', ' + TECH2.UFName + ' ' + TECH2.UMName,'N/A') AS AssignedTo,
			ISNULL(TECH3.ULName + ', ' + TECH3.UFName + ' ' + TECH3.UMName,'') AS ResolvedBy,
			ISNULL(TFF.Comments, '') AS Resolution,
			ISNULL(STAT.StatusDesc,'No Follow up') AS StatusDesc
		FROM TICKET_FEEDBACK AS TF
			INNER JOIN TICKET AS TKT
			ON TF.TicketId = TKT.TicketId
			INNER JOIN TICKET_ASSIGNMENT AS TA
			ON TKT.TicketId = TA.TicketId
			INNER JOIN TECHNICIAN AS TECH
			ON TKT.CreatedFor = TECH.UserId
			INNER JOIN AUDIENCE AS AUD
			ON TECH.AudienceId = AUD.AudienceId
			INNER JOIN TECHNICIAN AS TECH2
			ON TA.AssignedTo = TECH2.UserId
			LEFT OUTER JOIN TICKET_FEEDBACK_FOLLOW_UP AS TFF
			ON TF.TicketFeedbackId = TFF.TicketFeedbackId
			LEFT OUTER JOIN TECHNICIAN AS TECH3
			ON TFF.AssignedTo = TECH3.UserId
			LEFT OUTER JOIN TICKET_STATUS AS STAT
			ON TFF.StatusId = STAT.StatusId
		WHERE TF.CreatedDate BETWEEN dbo.StartOfDay(@sdate) 
			AND dbo.EndOfDay(@edate)
			AND TKT.TicketNumber = @num
	END
	ELSE IF @ucnt > 0
	BEGIN
		--Feedback Type
		IF @typ = 0
		BEGIN
			SELECT DISTINCT 
				TF.CreatedDate,
				TF.Comments, 
				TKT.TicketNumber, 
				TF.CustomerSatisfied,
				ISNULL(TECH.ULName + ', ' + TECH.UFName + ' ' + TECH.UMName,'Anonymous') AS CreatedFor,
				AUD.DisplayName,
				ISNULL(TECH2.ULName + ', ' + TECH2.UFName + ' ' + TECH2.UMName,'N/A') AS AssignedTo,
				ISNULL(TECH3.ULName + ', ' + TECH3.UFName + ' ' + TECH3.UMName,'') AS ResolvedBy,
				ISNULL(TFF.Comments, '') AS Resolution,
				ISNULL(STAT.StatusDesc,'No Follow up') AS StatusDesc
			FROM TICKET_FEEDBACK AS TF
				INNER JOIN TICKET AS TKT
				ON TF.TicketId = TKT.TicketId
				INNER JOIN TICKET_ASSIGNMENT AS TA
				ON TKT.TicketId = TA.TicketId
				INNER JOIN TECHNICIAN AS TECH
				ON TKT.CreatedFor = TECH.UserId
				INNER JOIN AUDIENCE AS AUD
				ON TECH.AudienceId = AUD.AudienceId
				INNER JOIN TECHNICIAN AS TECH2
				ON TA.AssignedTo = TECH2.UserId
				LEFT OUTER JOIN TICKET_FEEDBACK_FOLLOW_UP AS TFF
				ON TF.TicketFeedbackId = TFF.TicketFeedbackId
				LEFT OUTER JOIN TECHNICIAN AS TECH3
				ON TFF.AssignedTo = TECH3.UserId
				LEFT OUTER JOIN TICKET_STATUS AS STAT
				ON TFF.StatusId = STAT.StatusId
				INNER JOIN sessTECH_LIST AS STL
				ON STL.UserId = TA.AssignedTo
			WHERE TF.CreatedDate BETWEEN dbo.StartOfDay(@sdate) 
				AND dbo.EndOfDay(@edate)	
				AND STL.CreatedBy = @tech
				AND TF.CustomerSatisfied = 1
		END
		ELSE IF @typ = 1
		BEGIN
			--PRINT 'Type 1 with count'
			SELECT DISTINCT 
				TF.CreatedDate,
				TF.Comments, 
				TKT.TicketNumber, 
				TF.CustomerSatisfied,
				ISNULL(TECH.ULName + ', ' + TECH.UFName + ' ' + TECH.UMName,'Anonymous') AS CreatedFor,
				AUD.DisplayName,
				ISNULL(TECH2.ULName + ', ' + TECH2.UFName + ' ' + TECH2.UMName,'N/A') AS AssignedTo,
				ISNULL(TECH3.ULName + ', ' + TECH3.UFName + ' ' + TECH3.UMName,'') AS ResolvedBy,
				ISNULL(TFF.Comments, '') AS Resolution,
				ISNULL(STAT.StatusDesc,'No Follow up') AS StatusDesc
			FROM TICKET_FEEDBACK AS TF
				INNER JOIN TICKET AS TKT
				ON TF.TicketId = TKT.TicketId
				INNER JOIN TICKET_ASSIGNMENT AS TA
				ON TKT.TicketId = TA.TicketId
				INNER JOIN TECHNICIAN AS TECH
				ON TKT.CreatedFor = TECH.UserId
				INNER JOIN AUDIENCE AS AUD
				ON TECH.AudienceId = AUD.AudienceId
				INNER JOIN TECHNICIAN AS TECH2
				ON TA.AssignedTo = TECH2.UserId
				LEFT OUTER JOIN TICKET_FEEDBACK_FOLLOW_UP AS TFF
				ON TF.TicketFeedbackId = TFF.TicketFeedbackId
				LEFT OUTER JOIN TECHNICIAN AS TECH3
				ON TFF.AssignedTo = TECH3.UserId
				LEFT OUTER JOIN TICKET_STATUS AS STAT
				ON TFF.StatusId = STAT.StatusId
				INNER JOIN sessTECH_LIST AS STL
				ON STL.UserId = TA.AssignedTo
			WHERE TF.CreatedDate BETWEEN dbo.StartOfDay(@sdate) 
				AND dbo.EndOfDay(@edate)	
				AND STL.CreatedBy = @tech
				AND TF.CustomerSatisfied = 0
		END
		ELSE
		BEGIN
			--PRINT 'test'
			SELECT DISTINCT 
				TF.CreatedDate,
				TF.Comments, 
				TKT.TicketNumber, 
				TF.CustomerSatisfied,
				ISNULL(TECH.ULName + ', ' + TECH.UFName + ' ' + TECH.UMName,'Anonymous') AS CreatedFor,
				AUD.DisplayName,
				ISNULL(TECH2.ULName + ', ' + TECH2.UFName + ' ' + TECH2.UMName,'N/A') AS AssignedTo,
				ISNULL(TECH3.ULName + ', ' + TECH3.UFName + ' ' + TECH3.UMName,'') AS ResolvedBy,
				ISNULL(TFF.Comments, '') AS Resolution,
				ISNULL(STAT.StatusDesc,'No Follow up') AS StatusDesc
			FROM TICKET_FEEDBACK AS TF
				INNER JOIN TICKET AS TKT
				ON TF.TicketId = TKT.TicketId
				INNER JOIN TICKET_ASSIGNMENT AS TA
				ON TKT.TicketId = TA.TicketId
				INNER JOIN TECHNICIAN AS TECH
				ON TKT.CreatedFor = TECH.UserId
				INNER JOIN AUDIENCE AS AUD
				ON TECH.AudienceId = AUD.AudienceId
				INNER JOIN TECHNICIAN AS TECH2
				ON TA.AssignedTo = TECH2.UserId
				LEFT OUTER JOIN TICKET_FEEDBACK_FOLLOW_UP AS TFF
				ON TF.TicketFeedbackId = TFF.TicketFeedbackId
				LEFT OUTER JOIN TECHNICIAN AS TECH3
				ON TFF.AssignedTo = TECH3.UserId
				LEFT OUTER JOIN TICKET_STATUS AS STAT
				ON TFF.StatusId = STAT.StatusId
				INNER JOIN sessTECH_LIST AS STL
				ON STL.UserId = TA.AssignedTo
			WHERE TF.CreatedDate BETWEEN dbo.StartOfDay(@sdate) 
				AND dbo.EndOfDay(@edate)	
				AND STL.CreatedBy = @tech
			ORDER BY AssignedTo Desc
		END
	END
	ELSE
	BEGIN
		IF @typ = 0
		BEGIN
			SELECT DISTINCT 
				TF.CreatedDate,
				TF.Comments, 
				TKT.TicketNumber, 
				TF.CustomerSatisfied,
				ISNULL(TECH.ULName + ', ' + TECH.UFName + ' ' + TECH.UMName,'Anonymous') AS CreatedFor,
				AUD.DisplayName,
				ISNULL(TECH2.ULName + ', ' + TECH2.UFName + ' ' + TECH2.UMName,'N/A') AS AssignedTo,
				ISNULL(TECH3.ULName + ', ' + TECH3.UFName + ' ' + TECH3.UMName,'') AS ResolvedBy,
				ISNULL(TFF.Comments, '') AS Resolution,
				ISNULL(STAT.StatusDesc,'No Follow up') AS StatusDesc
			FROM TICKET_FEEDBACK AS TF
				INNER JOIN TICKET AS TKT
				ON TF.TicketId = TKT.TicketId
				INNER JOIN TICKET_ASSIGNMENT AS TA
				ON TKT.TicketId = TA.TicketId
				INNER JOIN TECHNICIAN AS TECH
				ON TKT.CreatedFor = TECH.UserId
				INNER JOIN AUDIENCE AS AUD
				ON TECH.AudienceId = AUD.AudienceId
				INNER JOIN TECHNICIAN AS TECH2
				ON TA.AssignedTo = TECH2.UserId
				LEFT OUTER JOIN TICKET_FEEDBACK_FOLLOW_UP AS TFF
				ON TF.TicketFeedbackId = TFF.TicketFeedbackId
				LEFT OUTER JOIN TECHNICIAN AS TECH3
				ON TFF.AssignedTo = TECH3.UserId
				LEFT OUTER JOIN TICKET_STATUS AS STAT
				ON TFF.StatusId = STAT.StatusId
			WHERE TF.CreatedDate BETWEEN dbo.StartOfDay(@sdate) 
				AND dbo.EndOfDay(@edate)
				AND TF.CustomerSatisfied = 1
		END
		ELSE IF @typ = 1
		BEGIN
			SELECT DISTINCT 
				TF.CreatedDate,
				TF.Comments, 
				TKT.TicketNumber, 
				TF.CustomerSatisfied,
				ISNULL(TECH.ULName + ', ' + TECH.UFName + ' ' + TECH.UMName,'Anonymous') AS CreatedFor,
				AUD.DisplayName,
				ISNULL(TECH2.ULName + ', ' + TECH2.UFName + ' ' + TECH2.UMName,'N/A') AS AssignedTo,
				ISNULL(TECH3.ULName + ', ' + TECH3.UFName + ' ' + TECH3.UMName,'') AS ResolvedBy,
				ISNULL(TFF.Comments, '') AS Resolution,
				ISNULL(STAT.StatusDesc,'No Follow up') AS StatusDesc
			FROM TICKET_FEEDBACK AS TF
				INNER JOIN TICKET AS TKT
				ON TF.TicketId = TKT.TicketId
				INNER JOIN TICKET_ASSIGNMENT AS TA
				ON TKT.TicketId = TA.TicketId
				INNER JOIN TECHNICIAN AS TECH
				ON TKT.CreatedFor = TECH.UserId
				INNER JOIN AUDIENCE AS AUD
				ON TECH.AudienceId = AUD.AudienceId
				INNER JOIN TECHNICIAN AS TECH2
				ON TA.AssignedTo = TECH2.UserId
				LEFT OUTER JOIN TICKET_FEEDBACK_FOLLOW_UP AS TFF
				ON TF.TicketFeedbackId = TFF.TicketFeedbackId
				LEFT OUTER JOIN TECHNICIAN AS TECH3
				ON TFF.AssignedTo = TECH3.UserId
				LEFT OUTER JOIN TICKET_STATUS AS STAT
				ON TFF.StatusId = STAT.StatusId
			WHERE TF.CreatedDate BETWEEN dbo.StartOfDay(@sdate) 
				AND dbo.EndOfDay(@edate)
				AND TF.CustomerSatisfied = 0
		END
		ELSE
		BEGIN
			SELECT DISTINCT 
				TF.CreatedDate,
				TF.Comments, 
				TKT.TicketNumber, 
				TF.CustomerSatisfied,
				ISNULL(TECH.ULName + ', ' + TECH.UFName + ' ' + TECH.UMName,'Anonymous') AS CreatedFor,
				AUD.DisplayName,
				ISNULL(TECH2.ULName + ', ' + TECH2.UFName + ' ' + TECH2.UMName,'N/A') AS AssignedTo,
				ISNULL(TECH3.ULName + ', ' + TECH3.UFName + ' ' + TECH3.UMName,'') AS ResolvedBy,
				ISNULL(TFF.Comments, '') AS Resolution,
				ISNULL(STAT.StatusDesc,'No Follow up') AS StatusDesc
			FROM TICKET_FEEDBACK AS TF
				INNER JOIN TICKET AS TKT
				ON TF.TicketId = TKT.TicketId
				INNER JOIN TICKET_ASSIGNMENT AS TA
				ON TKT.TicketId = TA.TicketId
				INNER JOIN TECHNICIAN AS TECH
				ON TKT.CreatedFor = TECH.UserId
				INNER JOIN AUDIENCE AS AUD
				ON TECH.AudienceId = AUD.AudienceId
				INNER JOIN TECHNICIAN AS TECH2
				ON TA.AssignedTo = TECH2.UserId
				LEFT OUTER JOIN TICKET_FEEDBACK_FOLLOW_UP AS TFF
				ON TF.TicketFeedbackId = TFF.TicketFeedbackId
				LEFT OUTER JOIN TECHNICIAN AS TECH3
				ON TFF.AssignedTo = TECH3.UserId
				LEFT OUTER JOIN TICKET_STATUS AS STAT
				ON TFF.StatusId = STAT.StatusId
			WHERE TF.CreatedDate BETWEEN dbo.StartOfDay(@sdate) 
				AND dbo.EndOfDay(@edate)
			
		END	
	END
END
