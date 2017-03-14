
CREATE PROCEDURE [dbo].[procENET_TICKET_SelectReportDetail]
(
	@stat int = 0,
	@sdate datetime,
	@edate datetime,
	@tech int,
	@num varchar(50) = ' '
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
--CHECK FOR Tech and Problem Type filters first.
DECLARE @ucnt int
DECLARE @pcnt int
DECLARE @scnt int

SET @ucnt = 0
SET @pcnt = 0
SET @scnt = 0

SET @ucnt = dbo.CountTechList(@tech)

SET @pcnt = dbo.CountProblemType(@tech)

SET @scnt = dbo.CountSystemType(@tech)
	
	IF LEN(@num) > 1
	BEGIN
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
				TKT.PatientImpact,
				ISNULL(TECH2.ULName,'') + ', ' + ISNULL(TECH2.UFName,'') AS Customer,
				CASE TKT.StatusId
					WHEN 3 THEN 0
					ELSE CAST(DateDiff(DAY,TKT.ClosedDate,TKT.OpenDate) as numeric) 
				END AS DaysOpened,
				TKT.Comments,
				TA.Remarks,
				STYP.SystemDesc,
				TKT.CustomerName
			FROM TICKET AS TKT
				INNER JOIN TICKET_ASSIGNMENT AS TA
				ON TKT.TicketId = TA.TicketId
				INNER JOIN TICKET_STATUS AS TS
				ON TS.StatusId = TKT.StatusId
				INNER JOIN TECHNICIAN AS TECH1
				ON TA.AssignedTo = TECH1.UserId
				INNER JOIN PROBLEM_TYPE AS PROB
				ON TKT.ProblemTypeId = PROB.ProblemTypeId
				INNER JOIN SYSTEM_TYPE AS STYP
				ON TKT.SystemNameId = STYP.SystemId
				INNER JOIN TECHNICIAN AS TECH2
				ON TECH2.UserId = TKT.CreatedFor
			WHERE TKT.TicketNumber = @num
	END
	ELSE IF @ucnt < 1 AND @pcnt < 1 AND @scnt < 1
	BEGIN
		IF @stat = 2
		BEGIN
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
				TKT.PatientImpact,
				ISNULL(TECH2.ULName,'') + ', ' + ISNULL(TECH2.UFName,'') AS Customer,
				CASE TKT.StatusId
					WHEN 3 THEN 0
					ELSE CAST(DateDiff(DAY,TKT.ClosedDate,TKT.OpenDate) as numeric) 
				END AS DaysOpened,
				TKT.Comments,
				TA.Remarks,
				STYP.SystemDesc,
				TKT.CustomerName
			FROM TICKET AS TKT
				INNER JOIN TICKET_ASSIGNMENT AS TA
				ON TKT.TicketId = TA.TicketId
				INNER JOIN TICKET_STATUS AS TS
				ON TS.StatusId = TKT.StatusId
				INNER JOIN TECHNICIAN AS TECH1
				ON TA.AssignedTo = TECH1.UserId
				INNER JOIN PROBLEM_TYPE AS PROB
				ON TKT.ProblemTypeId = PROB.ProblemTypeId
				INNER JOIN SYSTEM_TYPE AS STYP
				ON TKT.SystemNameId = STYP.SystemId
				INNER JOIN TECHNICIAN AS TECH2
				ON TECH2.UserId = TKT.CreatedFor
			WHERE TKT.CreatedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
				AND TKT.StatusId = 2
				AND TA.StatusId = 2
			ORDER BY PROB.ProblemTypeDesc
		END
		ELSE IF @stat = 3
		BEGIN
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
				TKT.PatientImpact,
				ISNULL(TECH2.ULName,'') + ', ' + ISNULL(TECH2.UFName,'') AS Customer,
				CASE TKT.StatusId
					WHEN 3 THEN 0
					ELSE CAST(DateDiff(DAY,TKT.ClosedDate,TKT.OpenDate) as numeric)  
				END AS DaysOpened,
				TKT.Comments,
				TA.Remarks,
				STYP.SystemDesc,
				TKT.CustomerName
			FROM TICKET AS TKT
				INNER JOIN TICKET_ASSIGNMENT AS TA
				ON TKT.TicketId = TA.TicketId
				INNER JOIN TICKET_STATUS AS TS
				ON TS.StatusId = TKT.StatusId
				INNER JOIN TECHNICIAN AS TECH1
				ON TA.AssignedTo = TECH1.UserId
				INNER JOIN PROBLEM_TYPE AS PROB
				ON TKT.ProblemTypeId = PROB.ProblemTypeId
				INNER JOIN SYSTEM_TYPE AS STYP
				ON TKT.SystemNameId = STYP.SystemId
				INNER JOIN TECHNICIAN AS TECH2
				ON TECH2.UserId = TKT.CreatedFor
			WHERE TKT.CreatedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
				AND TKT.StatusId = 3
				AND TA.StatusId = 3
			ORDER BY PROB.ProblemTypeDesc
		END
		ELSE
		BEGIN
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
				TKT.PatientImpact,
				ISNULL(TECH2.ULName,'') + ', ' + ISNULL(TECH2.UFName,'') AS Customer,
				CASE TKT.StatusId
					WHEN 3 THEN 0
					ELSE CAST(DateDiff(DAY,TKT.ClosedDate,TKT.OpenDate) as numeric) 
				END AS DaysOpened,
				TKT.Comments,
				TA.Remarks,
				STYP.SystemDesc,
				TKT.CustomerName
			FROM TICKET AS TKT
				INNER JOIN TICKET_ASSIGNMENT AS TA
				ON TKT.TicketId = TA.TicketId
				INNER JOIN TICKET_STATUS AS TS
				ON TS.StatusId = TKT.StatusId
				INNER JOIN TECHNICIAN AS TECH1
				ON TA.AssignedTo = TECH1.UserId
				INNER JOIN PROBLEM_TYPE AS PROB
				ON TKT.ProblemTypeId = PROB.ProblemTypeId
				INNER JOIN SYSTEM_TYPE AS STYP
				ON TKT.SystemNameId = STYP.SystemId
				INNER JOIN TECHNICIAN AS TECH2
				ON TECH2.UserId = TKT.CreatedFor
			WHERE TKT.CreatedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
			ORDER BY PROB.ProblemTypeDesc
		END
	END
	ELSE IF @ucnt > 0 AND @pcnt < 1 AND @scnt < 1 --USER ONLY COUNT > 0
	BEGIN
		IF @stat = 2
		BEGIN
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
				TKT.PatientImpact,
				ISNULL(TECH2.ULName,'') + ', ' + ISNULL(TECH2.UFName,'') AS Customer,
				CASE TKT.StatusId
					WHEN 3 THEN 0
					ELSE CAST(DateDiff(DAY,TKT.ClosedDate,TKT.OpenDate) as numeric) 
				END AS DaysOpened,
				TKT.Comments,
				TA.Remarks,
				STYP.SystemDesc,
				TKT.CustomerName
			FROM TICKET AS TKT
				INNER JOIN TICKET_ASSIGNMENT AS TA
				ON TKT.TicketId = TA.TicketId
				INNER JOIN TICKET_STATUS AS TS
				ON TS.StatusId = TKT.StatusId
				INNER JOIN TECHNICIAN AS TECH1
				ON TA.AssignedTo = TECH1.UserId
				INNER JOIN PROBLEM_TYPE AS PROB
				ON TKT.ProblemTypeId = PROB.ProblemTypeId
				INNER JOIN SYSTEM_TYPE AS STYP
				ON TKT.SystemNameId = STYP.SystemId
				INNER JOIN sessTECH_LIST AS STL
				ON STL.UserId = TA.AssignedTo
				INNER JOIN TECHNICIAN AS TECH2
				ON TECH2.UserId = TKT.CreatedFor
			WHERE TKT.CreatedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
				AND TKT.StatusId = 2
				AND STL.CreatedBy = @tech
				AND TA.StatusId = 2
			ORDER BY PROB.ProblemTypeDesc
		END
		ELSE IF @stat = 3
		BEGIN
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
				TKT.PatientImpact,
				ISNULL(TECH2.ULName,'') + ', ' + ISNULL(TECH2.UFName,'') AS Customer,
				CASE TKT.StatusId
					WHEN 3 THEN 0
					ELSE CAST(DateDiff(DAY,TKT.ClosedDate,TKT.OpenDate) as numeric)  
				END AS DaysOpened,
				TKT.Comments,
				TA.Remarks,
				STYP.SystemDesc,
				TKT.CustomerName
			FROM TICKET AS TKT
				INNER JOIN TICKET_ASSIGNMENT AS TA
				ON TKT.TicketId = TA.TicketId
				INNER JOIN TICKET_STATUS AS TS
				ON TS.StatusId = TKT.StatusId
				INNER JOIN TECHNICIAN AS TECH1
				ON TA.AssignedTo = TECH1.UserId
				INNER JOIN PROBLEM_TYPE AS PROB
				ON TKT.ProblemTypeId = PROB.ProblemTypeId
				INNER JOIN SYSTEM_TYPE AS STYP
				ON TKT.SystemNameId = STYP.SystemId
				INNER JOIN sessTECH_LIST AS STL
				ON STL.UserId = TA.AssignedTo
				INNER JOIN TECHNICIAN AS TECH2
				ON TECH2.UserId = TKT.CreatedFor
			WHERE TKT.CreatedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
				AND TKT.StatusId = 3
				AND STL.CreatedBy = @tech
				AND TA.StatusId = 3
			ORDER BY PROB.ProblemTypeDesc
		END
		ELSE
		BEGIN
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
				TKT.PatientImpact,
				ISNULL(TECH2.ULName,'') + ', ' + ISNULL(TECH2.UFName,'') AS Customer,
				CASE TKT.StatusId
					WHEN 3 THEN 0
					ELSE CAST(DateDiff(DAY,TKT.ClosedDate,TKT.OpenDate) as numeric)  
				END AS DaysOpened,
				TKT.Comments,
				TA.Remarks,
				STYP.SystemDesc,
				TKT.CustomerName
			FROM TICKET AS TKT
				INNER JOIN TICKET_ASSIGNMENT AS TA
				ON TKT.TicketId = TA.TicketId
				INNER JOIN TICKET_STATUS AS TS
				ON TS.StatusId = TKT.StatusId
				INNER JOIN TECHNICIAN AS TECH1
				ON TA.AssignedTo = TECH1.UserId
				INNER JOIN PROBLEM_TYPE AS PROB
				ON TKT.ProblemTypeId = PROB.ProblemTypeId
				INNER JOIN SYSTEM_TYPE AS STYP
				ON TKT.SystemNameId = STYP.SystemId
				INNER JOIN sessTECH_LIST AS STL
				ON STL.UserId = TA.AssignedTo
				INNER JOIN TECHNICIAN AS TECH2
				ON TECH2.UserId = TKT.CreatedFor
			WHERE TKT.CreatedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
				AND STL.CreatedBy = @tech
			ORDER BY PROB.ProblemTypeDesc
		END
	END
	ELSE IF @pcnt > 0 AND @ucnt < 1 AND @scnt < 1 --PROBLEM TYPE ONLY COUNT > 0
	BEGIN
		IF @stat = 2
		BEGIN
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
				TKT.PatientImpact,
				ISNULL(TECH2.ULName,'') + ', ' + ISNULL(TECH2.UFName,'') AS Customer,
				CASE TKT.StatusId
					WHEN 3 THEN 0
					ELSE CAST(DateDiff(DAY,TKT.ClosedDate,TKT.OpenDate) as numeric) 
				END AS DaysOpened,
				TKT.Comments,
				TA.Remarks,
				STYP.SystemDesc,
				TKT.CustomerName
			FROM TICKET AS TKT
				INNER JOIN TICKET_ASSIGNMENT AS TA
				ON TKT.TicketId = TA.TicketId
				INNER JOIN TICKET_STATUS AS TS
				ON TS.StatusId = TKT.StatusId
				INNER JOIN TECHNICIAN AS TECH1
				ON TA.AssignedTo = TECH1.UserId
				INNER JOIN PROBLEM_TYPE AS PROB
				ON TKT.ProblemTypeId = PROB.ProblemTypeId
				INNER JOIN sessPROBLEM_TYPE AS SPT
				ON SPT.ProblemTypeId = TKT.ProblemTypeId
				INNER JOIN SYSTEM_TYPE AS STYP
				ON TKT.SystemNameId = STYP.SystemId
				INNER JOIN TECHNICIAN AS TECH2
				ON TECH2.UserId = TKT.CreatedFor
			WHERE TKT.CreatedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
				AND TKT.StatusId = 2
				AND SPT.CreatedBy = @tech
				AND TA.StatusId = 2
			ORDER BY PROB.ProblemTypeDesc
		END
		ELSE IF @stat = 3
		BEGIN
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
				TKT.PatientImpact,
				ISNULL(TECH2.ULName,'') + ', ' + ISNULL(TECH2.UFName,'') AS Customer,
				CASE TKT.StatusId
					WHEN 3 THEN 0
					ELSE CAST(DateDiff(DAY,TKT.ClosedDate,TKT.OpenDate) as numeric)  
				END AS DaysOpened,
				TKT.Comments,
				TA.Remarks,
				STYP.SystemDesc,
				TKT.CustomerName
			FROM TICKET AS TKT
				INNER JOIN TICKET_ASSIGNMENT AS TA
				ON TKT.TicketId = TA.TicketId
				INNER JOIN TICKET_STATUS AS TS
				ON TS.StatusId = TKT.StatusId
				INNER JOIN TECHNICIAN AS TECH1
				ON TA.AssignedTo = TECH1.UserId
				INNER JOIN PROBLEM_TYPE AS PROB
				ON TKT.ProblemTypeId = PROB.ProblemTypeId
				INNER JOIN sessPROBLEM_TYPE AS SPT
				ON SPT.ProblemTypeId = TKT.ProblemTypeId
				INNER JOIN SYSTEM_TYPE AS STYP
				ON TKT.SystemNameId = STYP.SystemId
				INNER JOIN TECHNICIAN AS TECH2
				ON TECH2.UserId = TKT.CreatedFor
			WHERE TKT.CreatedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
				AND TKT.StatusId = 3
				AND SPT.CreatedBy = @tech
				AND TA.StatusId = 3
			ORDER BY PROB.ProblemTypeDesc
		END
		ELSE
		BEGIN
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
				TKT.PatientImpact,
				ISNULL(TECH2.ULName,'') + ', ' + ISNULL(TECH2.UFName,'') AS Customer,
				CASE TKT.StatusId
					WHEN 3 THEN 0
					ELSE CAST(DateDiff(DAY,TKT.ClosedDate,TKT.OpenDate) as numeric)  
				END AS DaysOpened,
				TKT.Comments,
				TA.Remarks,
				STYP.SystemDesc,
				TKT.CustomerName
			FROM TICKET AS TKT
				INNER JOIN TICKET_ASSIGNMENT AS TA
				ON TKT.TicketId = TA.TicketId
				INNER JOIN TICKET_STATUS AS TS
				ON TS.StatusId = TKT.StatusId
				INNER JOIN TECHNICIAN AS TECH1
				ON TA.AssignedTo = TECH1.UserId
				INNER JOIN PROBLEM_TYPE AS PROB
				ON TKT.ProblemTypeId = PROB.ProblemTypeId
				INNER JOIN sessPROBLEM_TYPE AS SPT
				ON SPT.ProblemTypeId = TKT.ProblemTypeId
				INNER JOIN SYSTEM_TYPE AS STYP
				ON TKT.SystemNameId = STYP.SystemId
				INNER JOIN TECHNICIAN AS TECH2
				ON TECH2.UserId = TKT.CreatedFor
			WHERE TKT.CreatedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
				AND SPT.CreatedBy = @tech
			ORDER BY PROB.ProblemTypeDesc
		END
	
	END
	
	ELSE IF @scnt > 0 AND @ucnt < 1 AND @pcnt < 1 --SYSTEM TYPE ONLY COUNT > 0
	BEGIN
		IF @stat = 2
		BEGIN
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
				TKT.PatientImpact,
				ISNULL(TECH2.ULName,'') + ', ' + ISNULL(TECH2.UFName,'') AS Customer,
				CASE TKT.StatusId
					WHEN 3 THEN 0
					ELSE CAST(DateDiff(DAY,TKT.ClosedDate,TKT.OpenDate) as numeric) 
				END AS DaysOpened,
				TKT.Comments,
				TA.Remarks,
				STYP.SystemDesc,
				TKT.CustomerName
			FROM TICKET AS TKT
				INNER JOIN TICKET_ASSIGNMENT AS TA
				ON TKT.TicketId = TA.TicketId
				INNER JOIN TICKET_STATUS AS TS
				ON TS.StatusId = TKT.StatusId
				INNER JOIN TECHNICIAN AS TECH1
				ON TA.AssignedTo = TECH1.UserId
				INNER JOIN PROBLEM_TYPE AS PROB
				ON TKT.ProblemTypeId = PROB.ProblemTypeId
				INNER JOIN SYSTEM_TYPE AS STYP
				ON TKT.SystemNameId = STYP.SystemId
				INNER JOIN sessSYSTEM_TYPE AS SST
				ON SST.SystemTypeId = TKT.SystemNameId
				INNER JOIN TECHNICIAN AS TECH2
				ON TECH2.UserId = TKT.CreatedFor
			WHERE TKT.CreatedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
				AND TKT.StatusId = 2
				AND SST.CreatedBy = @tech
				AND TA.StatusId = 2
			ORDER BY PROB.ProblemTypeDesc
		END
		ELSE IF @stat = 3
		BEGIN
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
				TKT.PatientImpact,
				ISNULL(TECH2.ULName,'') + ', ' + ISNULL(TECH2.UFName,'') AS Customer,
				CASE TKT.StatusId
					WHEN 3 THEN 0
					ELSE CAST(DateDiff(DAY,TKT.ClosedDate,TKT.OpenDate) as numeric)  
				END AS DaysOpened,
				TKT.Comments,
				TA.Remarks,
				STYP.SystemDesc,
				TKT.CustomerName
			FROM TICKET AS TKT
				INNER JOIN TICKET_ASSIGNMENT AS TA
				ON TKT.TicketId = TA.TicketId
				INNER JOIN TICKET_STATUS AS TS
				ON TS.StatusId = TKT.StatusId
				INNER JOIN TECHNICIAN AS TECH1
				ON TA.AssignedTo = TECH1.UserId
				INNER JOIN PROBLEM_TYPE AS PROB
				ON TKT.ProblemTypeId = PROB.ProblemTypeId
				INNER JOIN SYSTEM_TYPE AS STYP
				ON TKT.SystemNameId = STYP.SystemId
				INNER JOIN sessSYSTEM_TYPE AS SST
				ON SST.SystemTypeId = TKT.SystemNameId
				INNER JOIN TECHNICIAN AS TECH2
				ON TECH2.UserId = TKT.CreatedFor
			WHERE TKT.CreatedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
				AND TKT.StatusId = 3
				AND SST.CreatedBy = @tech
				AND TA.StatusId = 3
			ORDER BY PROB.ProblemTypeDesc
		END
		ELSE
		BEGIN
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
				TKT.PatientImpact,
				ISNULL(TECH2.ULName,'') + ', ' + ISNULL(TECH2.UFName,'') AS Customer,
				CASE TKT.StatusId
					WHEN 3 THEN 0
					ELSE CAST(DateDiff(DAY,TKT.ClosedDate,TKT.OpenDate) as numeric)  
				END AS DaysOpened,
				TKT.Comments,
				TA.Remarks,
				STYP.SystemDesc,
				TKT.CustomerName
			FROM TICKET AS TKT
				INNER JOIN TICKET_ASSIGNMENT AS TA
				ON TKT.TicketId = TA.TicketId
				INNER JOIN TICKET_STATUS AS TS
				ON TS.StatusId = TKT.StatusId
				INNER JOIN TECHNICIAN AS TECH1
				ON TA.AssignedTo = TECH1.UserId
				INNER JOIN PROBLEM_TYPE AS PROB
				ON TKT.ProblemTypeId = PROB.ProblemTypeId
				INNER JOIN SYSTEM_TYPE AS STYP
				ON TKT.SystemNameId = STYP.SystemId
				INNER JOIN sessSYSTEM_TYPE AS SST
				ON SST.SystemTypeId = TKT.SystemNameId
				INNER JOIN TECHNICIAN AS TECH2
				ON TECH2.UserId = TKT.CreatedFor
			WHERE TKT.CreatedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
				AND SST.CreatedBy = @tech
			ORDER BY PROB.ProblemTypeDesc
		END
	
	END
	
	--Add Combinations of two out of three
	ELSE IF @ucnt > 0 AND @pcnt > 0 AND @scnt < 1 --User + Problem Selected
	BEGIN
		IF @stat = 2
		BEGIN
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
				TKT.PatientImpact,
				ISNULL(TECH2.ULName,'') + ', ' + ISNULL(TECH2.UFName,'') AS Customer,
				CASE TKT.StatusId
					WHEN 3 THEN 0
					ELSE CAST(DateDiff(DAY,TKT.ClosedDate,TKT.OpenDate) as numeric) 
				END AS DaysOpened,
				TKT.Comments,
				TA.Remarks,
				STYP.SystemDesc,
				TKT.CustomerName
			FROM TICKET AS TKT
				INNER JOIN TICKET_ASSIGNMENT AS TA
				ON TKT.TicketId = TA.TicketId
				INNER JOIN TICKET_STATUS AS TS
				ON TS.StatusId = TKT.StatusId
				INNER JOIN TECHNICIAN AS TECH1
				ON TA.AssignedTo = TECH1.UserId
				INNER JOIN PROBLEM_TYPE AS PROB
				ON TKT.ProblemTypeId = PROB.ProblemTypeId
				INNER JOIN sessPROBLEM_TYPE AS SPT
				ON SPT.ProblemTypeId = TKT.ProblemTypeId
				INNER JOIN SYSTEM_TYPE AS STYP
				ON TKT.SystemNameId = STYP.SystemId
				INNER JOIN sessTECH_LIST AS STL
				ON STL.UserId = TA.AssignedTo
				INNER JOIN TECHNICIAN AS TECH2
				ON TECH2.UserId = TKT.CreatedFor
			WHERE TKT.CreatedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
				AND TKT.StatusId = 2
				AND SPT.CreatedBy = @tech
				AND STL.CreatedBy = @tech
				AND TA.StatusId = 2
			ORDER BY PROB.ProblemTypeDesc,TKT.TicketNumber
		END
		ELSE IF @stat = 3
		BEGIN
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
				TKT.PatientImpact,
				ISNULL(TECH2.ULName,'') + ', ' + ISNULL(TECH2.UFName,'') AS Customer,
				CASE TKT.StatusId
					WHEN 3 THEN 0
					ELSE CAST(DateDiff(DAY,TKT.ClosedDate,TKT.OpenDate) as numeric) 
				END AS DaysOpened,
				TKT.Comments,
				TA.Remarks,
				STYP.SystemDesc,
				TKT.CustomerName
			FROM TICKET AS TKT
				INNER JOIN TICKET_ASSIGNMENT AS TA
				ON TKT.TicketId = TA.TicketId
				INNER JOIN TICKET_STATUS AS TS
				ON TS.StatusId = TKT.StatusId
				INNER JOIN TECHNICIAN AS TECH1
				ON TA.AssignedTo = TECH1.UserId
				INNER JOIN PROBLEM_TYPE AS PROB
				ON TKT.ProblemTypeId = PROB.ProblemTypeId
				INNER JOIN sessPROBLEM_TYPE AS SPT
				ON SPT.ProblemTypeId = TKT.ProblemTypeId
				INNER JOIN SYSTEM_TYPE AS STYP
				ON TKT.SystemNameId = STYP.SystemId
				INNER JOIN sessTECH_LIST AS STL
				ON STL.UserId = TA.AssignedTo
				INNER JOIN TECHNICIAN AS TECH2
				ON TECH2.UserId = TKT.CreatedFor
			WHERE TKT.CreatedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
				AND TKT.StatusId = 3
				AND SPT.CreatedBy = @tech
				AND STL.CreatedBy = @tech
				AND TA.StatusId = 3
			ORDER BY PROB.ProblemTypeDesc,TKT.TicketNumber
		END
		ELSE
		BEGIN
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
				TKT.PatientImpact,
				ISNULL(TECH2.ULName,'') + ', ' + ISNULL(TECH2.UFName,'') AS Customer,
				CASE TKT.StatusId
					WHEN 3 THEN 0
					ELSE CAST(DateDiff(DAY,TKT.ClosedDate,TKT.OpenDate) as numeric) 
				END AS DaysOpened,
				TKT.Comments,
				TA.Remarks,
				STYP.SystemDesc,
				TKT.CustomerName
			FROM TICKET AS TKT
				INNER JOIN TICKET_ASSIGNMENT AS TA
				ON TKT.TicketId = TA.TicketId
				INNER JOIN TICKET_STATUS AS TS
				ON TS.StatusId = TKT.StatusId
				INNER JOIN TECHNICIAN AS TECH1
				ON TA.AssignedTo = TECH1.UserId
				INNER JOIN PROBLEM_TYPE AS PROB
				ON TKT.ProblemTypeId = PROB.ProblemTypeId
				INNER JOIN sessPROBLEM_TYPE AS SPT
				ON SPT.ProblemTypeId = TKT.ProblemTypeId
				INNER JOIN SYSTEM_TYPE AS STYP
				ON TKT.SystemNameId = STYP.SystemId
				INNER JOIN sessTECH_LIST AS STL
				ON STL.UserId = TA.AssignedTo
				INNER JOIN TECHNICIAN AS TECH2
				ON TECH2.UserId = TKT.CreatedFor
			WHERE TKT.CreatedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
				AND SPT.CreatedBy = @tech
				AND STL.CreatedBy = @tech
			ORDER BY PROB.ProblemTypeDesc,TKT.TicketNumber
		END
	END
	
	ELSE IF @ucnt > 0 AND @pcnt < 1 AND @scnt > 0 --user + system
	BEGIN
		IF @stat = 2
		BEGIN
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
				TKT.PatientImpact,
				ISNULL(TECH2.ULName,'') + ', ' + ISNULL(TECH2.UFName,'') AS Customer,
				CASE TKT.StatusId
					WHEN 3 THEN 0
					ELSE CAST(DateDiff(DAY,TKT.ClosedDate,TKT.OpenDate) as numeric) 
				END AS DaysOpened,
				TKT.Comments,
				TA.Remarks,
				STYP.SystemDesc,
				TKT.CustomerName
			FROM TICKET AS TKT
				INNER JOIN TICKET_ASSIGNMENT AS TA
				ON TKT.TicketId = TA.TicketId
				INNER JOIN TICKET_STATUS AS TS
				ON TS.StatusId = TKT.StatusId
				INNER JOIN TECHNICIAN AS TECH1
				ON TA.AssignedTo = TECH1.UserId
				INNER JOIN PROBLEM_TYPE AS PROB
				ON TKT.ProblemTypeId = PROB.ProblemTypeId
				INNER JOIN SYSTEM_TYPE AS STYP
				ON TKT.SystemNameId = STYP.SystemId
				INNER JOIN sessSYSTEM_TYPE AS SST
				ON SST.SystemTypeId = TKT.SystemNameId
				INNER JOIN sessTECH_LIST AS STL
				ON STL.UserId = TA.AssignedTo
				INNER JOIN TECHNICIAN AS TECH2
				ON TECH2.UserId = TKT.CreatedFor
			WHERE TKT.CreatedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
				AND TKT.StatusId = 2
				AND STL.CreatedBy = @tech
				AND SST.CreatedBy = @tech
				AND TA.StatusId = 2
			ORDER BY PROB.ProblemTypeDesc,TKT.TicketNumber
		END
		ELSE IF @stat = 3
		BEGIN
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
				TKT.PatientImpact,
				ISNULL(TECH2.ULName,'') + ', ' + ISNULL(TECH2.UFName,'') AS Customer,
				CASE TKT.StatusId
					WHEN 3 THEN 0
					ELSE CAST(DateDiff(DAY,TKT.ClosedDate,TKT.OpenDate) as numeric) 
				END AS DaysOpened,
				TKT.Comments,
				TA.Remarks,
				STYP.SystemDesc,
				TKT.CustomerName
			FROM TICKET AS TKT
				INNER JOIN TICKET_ASSIGNMENT AS TA
				ON TKT.TicketId = TA.TicketId
				INNER JOIN TICKET_STATUS AS TS
				ON TS.StatusId = TKT.StatusId
				INNER JOIN TECHNICIAN AS TECH1
				ON TA.AssignedTo = TECH1.UserId
				INNER JOIN PROBLEM_TYPE AS PROB
				ON TKT.ProblemTypeId = PROB.ProblemTypeId
				INNER JOIN SYSTEM_TYPE AS STYP
				ON TKT.SystemNameId = STYP.SystemId
				INNER JOIN sessSYSTEM_TYPE AS SST
				ON SST.SystemTypeId = TKT.SystemNameId
				INNER JOIN sessTECH_LIST AS STL
				ON STL.UserId = TA.AssignedTo
				INNER JOIN TECHNICIAN AS TECH2
				ON TECH2.UserId = TKT.CreatedFor
			WHERE TKT.CreatedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
				AND TKT.StatusId = 3
				AND STL.CreatedBy = @tech
				AND SST.CreatedBy = @tech
				AND TA.StatusId = 3
			ORDER BY PROB.ProblemTypeDesc,TKT.TicketNumber
		END
		ELSE
		BEGIN
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
				TKT.PatientImpact,
				ISNULL(TECH2.ULName,'') + ', ' + ISNULL(TECH2.UFName,'') AS Customer,
				CASE TKT.StatusId
					WHEN 3 THEN 0
					ELSE CAST(DateDiff(DAY,TKT.ClosedDate,TKT.OpenDate) as numeric) 
				END AS DaysOpened,
				TKT.Comments,
				TA.Remarks,
				STYP.SystemDesc,
				TKT.CustomerName
			FROM TICKET AS TKT
				INNER JOIN TICKET_ASSIGNMENT AS TA
				ON TKT.TicketId = TA.TicketId
				INNER JOIN TICKET_STATUS AS TS
				ON TS.StatusId = TKT.StatusId
				INNER JOIN TECHNICIAN AS TECH1
				ON TA.AssignedTo = TECH1.UserId
				INNER JOIN PROBLEM_TYPE AS PROB
				ON TKT.ProblemTypeId = PROB.ProblemTypeId
				INNER JOIN SYSTEM_TYPE AS STYP
				ON TKT.SystemNameId = STYP.SystemId
				INNER JOIN sessSYSTEM_TYPE AS SST
				ON SST.SystemTypeId = TKT.SystemNameId
				INNER JOIN sessTECH_LIST AS STL
				ON STL.UserId = TA.AssignedTo
				INNER JOIN TECHNICIAN AS TECH2
				ON TECH2.UserId = TKT.CreatedFor
			WHERE TKT.CreatedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
				AND STL.CreatedBy = @tech
				AND SST.CreatedBy = @tech
			ORDER BY PROB.ProblemTypeDesc,TKT.TicketNumber
		END
	END
	
	ELSE IF @ucnt < 1 AND @pcnt > 0 AND @scnt > 0 --Problem + System
	BEGIN
		IF @stat = 2
		BEGIN
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
				TKT.PatientImpact,
				ISNULL(TECH2.ULName,'') + ', ' + ISNULL(TECH2.UFName,'') AS Customer,
				CASE TKT.StatusId
					WHEN 3 THEN 0
					ELSE CAST(DateDiff(DAY,TKT.ClosedDate,TKT.OpenDate) as numeric) 
				END AS DaysOpened,
				TKT.Comments,
				TA.Remarks,
				STYP.SystemDesc,
				TKT.CustomerName
			FROM TICKET AS TKT
				INNER JOIN TICKET_ASSIGNMENT AS TA
				ON TKT.TicketId = TA.TicketId
				INNER JOIN TICKET_STATUS AS TS
				ON TS.StatusId = TKT.StatusId
				INNER JOIN TECHNICIAN AS TECH1
				ON TA.AssignedTo = TECH1.UserId
				INNER JOIN PROBLEM_TYPE AS PROB
				ON TKT.ProblemTypeId = PROB.ProblemTypeId
				INNER JOIN sessPROBLEM_TYPE AS SPT
				ON SPT.ProblemTypeId = TKT.ProblemTypeId
				INNER JOIN SYSTEM_TYPE AS STYP
				ON TKT.SystemNameId = STYP.SystemId
				INNER JOIN sessSYSTEM_TYPE AS SST
				ON SST.SystemTypeId = TKT.SystemNameId
				INNER JOIN TECHNICIAN AS TECH2
				ON TECH2.UserId = TKT.CreatedFor
			WHERE TKT.CreatedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
				AND TKT.StatusId = 2
				AND SPT.CreatedBy = @tech
				AND SST.CreatedBy = @tech
				AND TA.StatusId = 2
			ORDER BY PROB.ProblemTypeDesc,TKT.TicketNumber
		END
		ELSE IF @stat = 3
		BEGIN
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
				TKT.PatientImpact,
				ISNULL(TECH2.ULName,'') + ', ' + ISNULL(TECH2.UFName,'') AS Customer,
				CASE TKT.StatusId
					WHEN 3 THEN 0
					ELSE CAST(DateDiff(DAY,TKT.ClosedDate,TKT.OpenDate) as numeric) 
				END AS DaysOpened,
				TKT.Comments,
				TA.Remarks,
				STYP.SystemDesc,
				TKT.CustomerName
			FROM TICKET AS TKT
				INNER JOIN TICKET_ASSIGNMENT AS TA
				ON TKT.TicketId = TA.TicketId
				INNER JOIN TICKET_STATUS AS TS
				ON TS.StatusId = TKT.StatusId
				INNER JOIN TECHNICIAN AS TECH1
				ON TA.AssignedTo = TECH1.UserId
				INNER JOIN PROBLEM_TYPE AS PROB
				ON TKT.ProblemTypeId = PROB.ProblemTypeId
				INNER JOIN sessPROBLEM_TYPE AS SPT
				ON SPT.ProblemTypeId = TKT.ProblemTypeId
				INNER JOIN SYSTEM_TYPE AS STYP
				ON TKT.SystemNameId = STYP.SystemId
				INNER JOIN sessSYSTEM_TYPE AS SST
				ON SST.SystemTypeId = TKT.SystemNameId
				INNER JOIN TECHNICIAN AS TECH2
				ON TECH2.UserId = TKT.CreatedFor
			WHERE TKT.CreatedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
				AND TKT.StatusId = 3
				AND SPT.CreatedBy = @tech
				AND SST.CreatedBy = @tech
				AND TA.StatusId = 3
			ORDER BY PROB.ProblemTypeDesc,TKT.TicketNumber
		END
		ELSE
		BEGIN
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
				TKT.PatientImpact,
				ISNULL(TECH2.ULName,'') + ', ' + ISNULL(TECH2.UFName,'') AS Customer,
				CASE TKT.StatusId
					WHEN 3 THEN 0
					ELSE CAST(DateDiff(DAY,TKT.ClosedDate,TKT.OpenDate) as numeric) 
				END AS DaysOpened,
				TKT.Comments,
				TA.Remarks,
				STYP.SystemDesc,
				TKT.CustomerName
			FROM TICKET AS TKT
				INNER JOIN TICKET_ASSIGNMENT AS TA
				ON TKT.TicketId = TA.TicketId
				INNER JOIN TICKET_STATUS AS TS
				ON TS.StatusId = TKT.StatusId
				INNER JOIN TECHNICIAN AS TECH1
				ON TA.AssignedTo = TECH1.UserId
				INNER JOIN PROBLEM_TYPE AS PROB
				ON TKT.ProblemTypeId = PROB.ProblemTypeId
				INNER JOIN sessPROBLEM_TYPE AS SPT
				ON SPT.ProblemTypeId = TKT.ProblemTypeId
				INNER JOIN SYSTEM_TYPE AS STYP
				ON TKT.SystemNameId = STYP.SystemId
				INNER JOIN sessSYSTEM_TYPE AS SST
				ON SST.SystemTypeId = TKT.SystemNameId
				INNER JOIN TECHNICIAN AS TECH2
				ON TECH2.UserId = TKT.CreatedFor
			WHERE TKT.CreatedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
				AND SPT.CreatedBy = @tech
				AND SST.CreatedBy = @tech
			ORDER BY PROB.ProblemTypeDesc,TKT.TicketNumber
		END
	END
	--End Combinations
	
	ELSE IF @ucnt > 0 AND @pcnt > 0 AND @scnt > 0 --All
	BEGIN
		IF @stat = 2
		BEGIN
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
				TKT.PatientImpact,
				ISNULL(TECH2.ULName,'') + ', ' + ISNULL(TECH2.UFName,'') AS Customer,
				CASE TKT.StatusId
					WHEN 3 THEN 0
					ELSE CAST(DateDiff(DAY,TKT.ClosedDate,TKT.OpenDate) as numeric) 
				END AS DaysOpened,
				TKT.Comments,
				TA.Remarks,
				STYP.SystemDesc,
				TKT.CustomerName
			FROM TICKET AS TKT
				INNER JOIN TICKET_ASSIGNMENT AS TA
				ON TKT.TicketId = TA.TicketId
				INNER JOIN TICKET_STATUS AS TS
				ON TS.StatusId = TKT.StatusId
				INNER JOIN TECHNICIAN AS TECH1
				ON TA.AssignedTo = TECH1.UserId
				INNER JOIN PROBLEM_TYPE AS PROB
				ON TKT.ProblemTypeId = PROB.ProblemTypeId
				INNER JOIN sessPROBLEM_TYPE AS SPT
				ON SPT.ProblemTypeId = TKT.ProblemTypeId
				INNER JOIN SYSTEM_TYPE AS STYP
				ON TKT.SystemNameId = STYP.SystemId
				INNER JOIN sessSYSTEM_TYPE AS SST
				ON TKT.SystemNameId = SST.SystemTypeId
				INNER JOIN sessTECH_LIST AS STL
				ON STL.UserId = TA.AssignedTo
				INNER JOIN TECHNICIAN AS TECH2
				ON TECH2.UserId = TKT.CreatedFor
			WHERE TKT.CreatedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
				AND TKT.StatusId = 2
				AND SPT.CreatedBy = @tech
				AND STL.CreatedBy = @tech
				AND SST.CreatedBy = @tech
				AND TA.StatusId = 2
			ORDER BY PROB.ProblemTypeDesc
		END
		ELSE IF @stat = 3
		BEGIN
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
				TKT.PatientImpact,
				ISNULL(TECH2.ULName,'') + ', ' + ISNULL(TECH2.UFName,'') AS Customer,
				CASE TKT.StatusId
					WHEN 3 THEN 0
					ELSE CAST(DateDiff(DAY,TKT.ClosedDate,TKT.OpenDate) as numeric) 
				END AS DaysOpened,
				TKT.Comments,
				TA.Remarks,
				STYP.SystemDesc,
				TKT.CustomerName
			FROM TICKET AS TKT
				INNER JOIN TICKET_ASSIGNMENT AS TA
				ON TKT.TicketId = TA.TicketId
				INNER JOIN TICKET_STATUS AS TS
				ON TS.StatusId = TKT.StatusId
				INNER JOIN TECHNICIAN AS TECH1
				ON TA.AssignedTo = TECH1.UserId
				INNER JOIN PROBLEM_TYPE AS PROB
				ON TKT.ProblemTypeId = PROB.ProblemTypeId
				INNER JOIN sessPROBLEM_TYPE AS SPT
				ON SPT.ProblemTypeId = TKT.ProblemTypeId
				INNER JOIN SYSTEM_TYPE AS STYP
				ON TKT.SystemNameId = STYP.SystemId
				INNER JOIN sessSYSTEM_TYPE AS SST
				ON TKT.SystemNameId = SST.SystemTypeId
				INNER JOIN sessTECH_LIST AS STL
				ON STL.UserId = TA.AssignedTo
				INNER JOIN TECHNICIAN AS TECH2
				ON TECH2.UserId = TKT.CreatedFor
			WHERE TKT.CreatedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
				AND TKT.StatusId = 3
				AND SPT.CreatedBy = @tech
				AND STL.CreatedBy = @tech
				AND SST.CreatedBy = @tech
				AND TA.StatusId = 3
			ORDER BY PROB.ProblemTypeDesc
		END
		ELSE
		BEGIN
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
				TKT.PatientImpact,
				ISNULL(TECH2.ULName,'') + ', ' + ISNULL(TECH2.UFName,'') AS Customer,
				CASE TKT.StatusId
					WHEN 3 THEN 0
					ELSE CAST(DateDiff(DAY,TKT.ClosedDate,TKT.OpenDate) as numeric) 
				END AS DaysOpened,
				TKT.Comments,
				TA.Remarks,
				STYP.SystemDesc,
				TKT.CustomerName
			FROM TICKET AS TKT
				INNER JOIN TICKET_ASSIGNMENT AS TA
				ON TKT.TicketId = TA.TicketId
				INNER JOIN TICKET_STATUS AS TS
				ON TS.StatusId = TKT.StatusId
				INNER JOIN TECHNICIAN AS TECH1
				ON TA.AssignedTo = TECH1.UserId
				INNER JOIN PROBLEM_TYPE AS PROB
				ON TKT.ProblemTypeId = PROB.ProblemTypeId
				INNER JOIN sessPROBLEM_TYPE AS SPT
				ON SPT.ProblemTypeId = TKT.ProblemTypeId
				INNER JOIN SYSTEM_TYPE AS STYP
				ON TKT.SystemNameId = STYP.SystemId
				INNER JOIN sessSYSTEM_TYPE AS SST
				ON TKT.SystemNameId = SST.SystemTypeId
				INNER JOIN sessTECH_LIST AS STL
				ON STL.UserId = TA.AssignedTo
				INNER JOIN TECHNICIAN AS TECH2
				ON TECH2.UserId = TKT.CreatedFor
			WHERE TKT.CreatedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
				AND SPT.CreatedBy = @tech
				AND STL.CreatedBy = @tech
				AND SST.CreatedBy = @tech
			ORDER BY PROB.ProblemTypeDesc
		END
	END
END

