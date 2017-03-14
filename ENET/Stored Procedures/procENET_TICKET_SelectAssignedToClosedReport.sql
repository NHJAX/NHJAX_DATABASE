
create PROCEDURE [dbo].[procENET_TICKET_SelectAssignedToClosedReport]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT TKT.TicketNumber, 
		TS.StatusDesc, 
		ISNULL(TECH1.ULName,'') + ', ' + ISNULL(TECH1.UFName,'') AS AssignedTo,
		TA.AssignmentDate,
		TA.Hours,
		PROB.ProblemTypeDesc,
		TKT.ClosedDate,
		TKT.OpenDate,
		TA.HoursToClose,
		TA.DaysToClose,
		TKT.PatientImpact
	FROM TICKET AS TKT
		INNER JOIN TICKET_ASSIGNMENT AS TA
		ON TKT.TicketId = TA.TicketId
		INNER JOIN TICKET_STATUS AS TS
		ON TS.StatusId = TKT.StatusId
		INNER JOIN TECHNICIAN AS TECH1
		ON TA.AssignedTo = TECH1.UserId
		INNER JOIN PROBLEM_TYPE AS PROB
		ON TKT.ProblemTypeId = PROB.ProblemTypeId
	WHERE TA.StatusId = 2
		AND TECH1.Inactive = 1
	ORDER BY PROB.ProblemTypeDesc

END

