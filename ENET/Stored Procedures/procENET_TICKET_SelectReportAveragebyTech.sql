
CREATE PROCEDURE [dbo].[procENET_TICKET_SelectReportAveragebyTech]
(
	@sdate datetime,
	@edate datetime,
	@tech int
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

	IF @ucnt < 1 AND @pcnt < 1 AND @scnt < 1
	BEGIN
		SELECT TOP (100) PERCENT 
			TECH.ULName + ', ' + TECH.UFName + ' ' + TECH.UMName AS TechName,  
			COUNT(TAVG.TicketId) AS NumberofTickets, 
			CAST(AVG(TAVG.DaysToClose) AS numeric(5,2)) AS AverageDaysToClose,
			CAST(AVG(TAVG.HoursToClose) AS numeric(5,2)) AS AverageHoursToClose, 
			SUM(TAVG.Hours) AS TotalHours
		FROM dbo.vwENET_TICKETCloseAveragesHours AS TAVG
			INNER JOIN TICKET AS TKT
			ON TKT.TicketId = TAVG.TicketId
			INNER JOIN TICKET_ASSIGNMENT AS TA
			ON TKT.TicketId = TA.TicketId
			INNER JOIN TECHNICIAN AS TECH
			ON TA.AssignedTo = TECH.UserId
		WHERE TKT.ClosedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
		GROUP BY TECH.ULName, TECH.UFName, TECH.UMName
		ORDER BY TechName
	END
	ELSE IF @ucnt > 0 AND @pcnt < 1 AND @scnt < 1 --USER ONLY COUNT > 0
	BEGIN
		SELECT TOP (100) PERCENT 
			TECH.ULName + ', ' + TECH.UFName + ' ' + TECH.UMName AS TechName, 
			COUNT(TAVG.TicketId) AS NumberofTickets, 
			CAST(AVG(TAVG.DaysToClose) AS numeric(5,2)) AS AverageDaysToClose,
			CAST(AVG(TAVG.HoursToClose) AS numeric(5,2)) AS AverageHoursToClose,  
			SUM(TAVG.Hours) AS TotalHours
		FROM dbo.vwENET_TICKETCloseAveragesHours AS TAVG
			INNER JOIN TICKET AS TKT
			ON TKT.TicketId = TAVG.TicketId
			INNER JOIN TICKET_ASSIGNMENT AS TA
			ON TKT.TicketId = TA.TicketId
			INNER JOIN sessTECH_LIST AS STL
			ON STL.UserId = TA.AssignedTo
			INNER JOIN TECHNICIAN AS TECH
			ON TA.AssignedTo = TECH.UserId
		WHERE TKT.ClosedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
			AND STL.CreatedBy = @tech	
		GROUP BY TECH.ULName, TECH.UFName, TECH.UMName
		ORDER BY TechName
	END
	ELSE IF @pcnt > 0 AND @ucnt < 1 AND @scnt < 1 --PROBLEM TYPE ONLY COUNT > 0
	BEGIN
		SELECT TOP (100) PERCENT 
			TECH.ULName + ', ' + TECH.UFName + ' ' + TECH.UMName AS TechName,  
			COUNT(TAVG.TicketId) AS NumberofTickets, 
			CAST(AVG(TAVG.DaysToClose) AS numeric(5,2)) AS AverageDaysToClose,
			CAST(AVG(TAVG.HoursToClose) AS numeric(5,2)) AS AverageHoursToClose,  
			SUM(TAVG.Hours) AS TotalHours
		FROM dbo.vwENET_TICKETCloseAveragesHours AS TAVG
			INNER JOIN TICKET AS TKT
			ON TKT.TicketId = TAVG.TicketId
			INNER JOIN sessPROBLEM_TYPE AS SPT
			ON SPT.ProblemTypeId = TKT.ProblemTypeId
			INNER JOIN TICKET_ASSIGNMENT AS TA
			ON TKT.TicketId = TA.TicketId
			INNER JOIN TECHNICIAN AS TECH
			ON TA.AssignedTo = TECH.UserId
		WHERE TKT.ClosedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
			AND SPT.CreatedBy = @tech
		GROUP BY TECH.ULName, TECH.UFName, TECH.UMName
		ORDER BY TechName
	END
	ELSE IF @scnt > 0 AND @ucnt < 1 AND @pcnt < 1 --SYSTEM TYPE ONLY COUNT > 0
	BEGIN
		SELECT TOP (100) PERCENT 
			TECH.ULName + ', ' + TECH.UFName + ' ' + TECH.UMName AS TechName,  
			COUNT(TAVG.TicketId) AS NumberofTickets, 
			CAST(AVG(TAVG.DaysToClose) AS numeric(5,2)) AS AverageDaysToClose,
			CAST(AVG(TAVG.HoursToClose) AS numeric(5,2)) AS AverageHoursToClose,  
			SUM(TAVG.Hours) AS TotalHours
		FROM dbo.vwENET_TICKETCloseAveragesHours AS TAVG
			INNER JOIN TICKET AS TKT
			ON TKT.TicketId = TAVG.TicketId
			INNER JOIN sessSYSTEM_TYPE AS SST
			ON SST.SystemTypeId = TKT.SystemNameId
			INNER JOIN TICKET_ASSIGNMENT AS TA
			ON TKT.TicketId = TA.TicketId
			INNER JOIN TECHNICIAN AS TECH
			ON TA.AssignedTo = TECH.UserId
		WHERE TKT.ClosedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
			AND SST.CreatedBy = @tech
		GROUP BY TECH.ULName, TECH.UFName, TECH.UMName
		ORDER BY TechName
	END
	--combos
	ELSE IF @ucnt > 0 AND @pcnt > 0 AND @scnt < 1
	BEGIN
		SELECT TOP (100) PERCENT 
			TECH.ULName + ', ' + TECH.UFName + ' ' + TECH.UMName AS TechName, 
			COUNT(TAVG.TicketId) AS NumberofTickets, 
			CAST(AVG(TAVG.DaysToClose) AS numeric(5,2)) AS AverageDaysToClose,
			CAST(AVG(TAVG.HoursToClose) AS numeric(5,2)) AS AverageHoursToClose,   
			SUM(TAVG.Hours) AS TotalHours
		FROM dbo.vwENET_TICKETCloseAveragesHours AS TAVG
			INNER JOIN TICKET AS TKT
			ON TKT.TicketId = TAVG.TicketId
			INNER JOIN TICKET_ASSIGNMENT AS TA
			ON TKT.TicketId = TA.TicketId
			INNER JOIN sessTECH_LIST AS STL
			ON STL.UserId = TA.AssignedTo
			INNER JOIN sessPROBLEM_TYPE AS SPT
			ON SPT.ProblemTypeId = TKT.ProblemTypeId
			INNER JOIN TECHNICIAN AS TECH
			ON TA.AssignedTo = TECH.UserId
		WHERE TKT.ClosedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
			AND STL.CreatedBy = @tech
			AND SPT.CreatedBy = @tech
		GROUP BY TECH.ULName, TECH.UFName, TECH.UMName
		ORDER BY TechName
	END
	ELSE IF @ucnt < 1 AND @pcnt > 0 AND @scnt > 0
	BEGIN
		SELECT TOP (100) PERCENT 
			TECH.ULName + ', ' + TECH.UFName + ' ' + TECH.UMName AS TechName, 
			COUNT(TAVG.TicketId) AS NumberofTickets, 
			CAST(AVG(TAVG.DaysToClose) AS numeric(5,2)) AS AverageDaysToClose,
			CAST(AVG(TAVG.HoursToClose) AS numeric(5,2)) AS AverageHoursToClose,   
			SUM(TAVG.Hours) AS TotalHours
		FROM dbo.vwENET_TICKETCloseAveragesHours AS TAVG
			INNER JOIN TICKET AS TKT
			ON TKT.TicketId = TAVG.TicketId
			INNER JOIN TICKET_ASSIGNMENT AS TA
			ON TKT.TicketId = TA.TicketId
			INNER JOIN sessPROBLEM_TYPE AS SPT
			ON SPT.ProblemTypeId = TKT.ProblemTypeId
			INNER JOIN sessSYSTEM_TYPE AS SST
			ON SST.SystemTypeId = TKT.SystemNameId
			INNER JOIN TECHNICIAN AS TECH
			ON TA.AssignedTo = TECH.UserId
		WHERE TKT.ClosedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
			AND SPT.CreatedBy = @tech
			AND SST.CreatedBy = @tech
		GROUP BY TECH.ULName, TECH.UFName, TECH.UMName
		ORDER BY TechName
	END
	ELSE IF @ucnt > 0 AND @pcnt < 1 AND @scnt > 0
	BEGIN
		SELECT TOP (100) PERCENT 
			TECH.ULName + ', ' + TECH.UFName + ' ' + TECH.UMName AS TechName, 
			COUNT(TAVG.TicketId) AS NumberofTickets, 
			CAST(AVG(TAVG.DaysToClose) AS numeric(5,2)) AS AverageDaysToClose,
			CAST(AVG(TAVG.HoursToClose) AS numeric(5,2)) AS AverageHoursToClose,   
			SUM(TAVG.Hours) AS TotalHours
		FROM dbo.vwENET_TICKETCloseAveragesHours AS TAVG
			INNER JOIN TICKET AS TKT
			ON TKT.TicketId = TAVG.TicketId
			INNER JOIN TICKET_ASSIGNMENT AS TA
			ON TKT.TicketId = TA.TicketId
			INNER JOIN sessTECH_LIST AS STL
			ON STL.UserId = TA.AssignedTo
			INNER JOIN sessSYSTEM_TYPE AS SST
			ON SST.SystemTypeId = TKT.SystemNameId
			INNER JOIN TECHNICIAN AS TECH
			ON TA.AssignedTo = TECH.UserId
		WHERE TKT.ClosedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
			AND STL.CreatedBy = @tech
			AND SST.CreatedBy = @tech
		GROUP BY TECH.ULName, TECH.UFName, TECH.UMName
		ORDER BY TechName
	END
	--end combos
	ELSE IF @ucnt > 0 AND @pcnt > 0 AND @scnt > 0
	BEGIN
		SELECT TOP (100) PERCENT 
			TECH.ULName + ', ' + TECH.UFName + ' ' + TECH.UMName AS TechName, 
			COUNT(TAVG.TicketId) AS NumberofTickets, 
			CAST(AVG(TAVG.DaysToClose) AS numeric(5,2)) AS AverageDaysToClose,
			CAST(AVG(TAVG.HoursToClose) AS numeric(5,2)) AS AverageHoursToClose,   
			SUM(TAVG.Hours) AS TotalHours
		FROM dbo.vwENET_TICKETCloseAveragesHours AS TAVG
			INNER JOIN TICKET AS TKT
			ON TKT.TicketId = TAVG.TicketId
			INNER JOIN TICKET_ASSIGNMENT AS TA
			ON TKT.TicketId = TA.TicketId
			INNER JOIN sessTECH_LIST AS STL
			ON STL.UserId = TA.AssignedTo
			INNER JOIN sessPROBLEM_TYPE AS SPT
			ON SPT.ProblemTypeId = TKT.ProblemTypeId
			INNER JOIN sessSYSTEM_TYPE AS SST
			ON SST.SystemTypeId = TKT.SystemNameId
			INNER JOIN TECHNICIAN AS TECH
			ON TA.AssignedTo = TECH.UserId
		WHERE TKT.ClosedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
			AND STL.CreatedBy = @tech
			AND SPT.CreatedBy = @tech
			AND SST.CreatedBy = @tech
		GROUP BY TECH.ULName, TECH.UFName, TECH.UMName
		ORDER BY TechName
	END
END

