
CREATE PROCEDURE [dbo].[procENET_TICKET_SelectReportAverageDetail]
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
		SELECT DISTINCT TOP (100) PERCENT 
			dbo.FormatDateWithoutTime(TAVG.ClosedDate, 3) AS DateId, 
			YEAR(TAVG.ClosedDate) AS Yr, 
			MONTH(TAVG.ClosedDate) AS Mth, 
			COUNT(TAVG.TicketId) AS NumberofTickets, 
			TAVG.DaysToClose AS AverageDaysToClose, 
			TAVG.Hours AS AverageHours,
			TKT.TicketNumber
		FROM TICKET AS TKT
			INNER JOIN dbo.vwENET_TICKET_ASSIGNMENTCloseAverages AS TAVG
			ON TKT.TicketId = TAVG.TicketId
		WHERE TAVG.ClosedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
		GROUP BY YEAR(TAVG.ClosedDate), 
			MONTH(TAVG.ClosedDate), 
			dbo.FormatDateWithoutTime(TAVG.ClosedDate, 3),
			TKT.TicketNumber,
			TAVG.DaysToClose,
			TAVG.Hours
		ORDER BY Yr, Mth
	END
	ELSE IF @ucnt > 0 AND @pcnt < 1 AND @scnt < 1 --USER ONLY COUNT > 0
	BEGIN
		SELECT DISTINCT TOP (100) PERCENT 
			dbo.FormatDateWithoutTime(TAVG.ClosedDate, 3) AS DateId, 
			YEAR(TAVG.ClosedDate) AS Yr, 
			MONTH(TAVG.ClosedDate) AS Mth, 
			COUNT(TAVG.TicketId) AS NumberofTickets, 
			TAVG.DaysToClose AS AverageDaysToClose, 
			TAVG.Hours AS AverageHours,
			TKT.TicketNumber
		FROM TICKET AS TKT
			INNER JOIN dbo.vwENET_TICKET_ASSIGNMENTCloseAverages AS TAVG
			ON TKT.TicketId = TAVG.TicketId
		WHERE TAVG.ClosedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
			AND TAVG.AssignedTo IN 
				(SELECT UserId FROM sessTECH_LIST 
					WHERE CreatedBy = @tech)
		GROUP BY YEAR(TAVG.ClosedDate), 
			MONTH(TAVG.ClosedDate), 
			dbo.FormatDateWithoutTime(TAVG.ClosedDate, 3),
			TKT.TicketNumber,
			TAVG.DaysToClose,
			TAVG.Hours
		ORDER BY Yr, Mth
	END
	ELSE IF @pcnt > 0 AND @ucnt < 1 AND @scnt < 1 --PROBLEM TYPE ONLY COUNT > 0
	BEGIN
		SELECT DISTINCT TOP (100) PERCENT 
			dbo.FormatDateWithoutTime(TAVG.ClosedDate, 3) AS DateId, 
			YEAR(TAVG.ClosedDate) AS Yr, 
			MONTH(TAVG.ClosedDate) AS Mth, 
			COUNT(TAVG.TicketId) AS NumberofTickets, 
			TAVG.DaysToClose AS AverageDaysToClose, 
			TAVG.Hours AS AverageHours,
			TKT.TicketNumber
		FROM TICKET AS TKT
			INNER JOIN dbo.vwENET_TICKET_ASSIGNMENTCloseAverages AS TAVG
			ON TKT.TicketId = TAVG.TicketId
		WHERE TAVG.ClosedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
			AND TKT.ProblemTypeId IN
				(SELECT ProblemTypeId FROM sessPROBLEM_TYPE
					WHERE CreatedBy = @tech)
		GROUP BY YEAR(TAVG.ClosedDate), MONTH(TAVG.ClosedDate), 
			dbo.FormatDateWithoutTime(TAVG.ClosedDate, 3),
			TKT.TicketNumber,
			TAVG.DaysToClose,
			TAVG.Hours
		ORDER BY Yr, Mth
	END
	ELSE IF @scnt > 0 AND @ucnt < 1 AND @pcnt < 1 --SYSTEM TYPE ONLY COUNT > 0
	BEGIN
		SELECT DISTINCT TOP (100) PERCENT 
			dbo.FormatDateWithoutTime(TAVG.ClosedDate, 3) AS DateId, 
			YEAR(TAVG.ClosedDate) AS Yr, 
			MONTH(TAVG.ClosedDate) AS Mth, 
			COUNT(TAVG.TicketId) AS NumberofTickets, 
			TAVG.DaysToClose AS AverageDaysToClose, 
			TAVG.Hours AS AverageHours,
			TKT.TicketNumber
		FROM TICKET AS TKT
			INNER JOIN dbo.vwENET_TICKET_ASSIGNMENTCloseAverages AS TAVG
			ON TKT.TicketId = TAVG.TicketId
		WHERE TAVG.ClosedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
			AND TKT.SystemNameId IN
				(SELECT SystemTypeId FROM sessSYSTEM_TYPE
					WHERE CreatedBy = @tech)
		GROUP BY YEAR(TAVG.ClosedDate), MONTH(TAVG.ClosedDate), 
			dbo.FormatDateWithoutTime(TAVG.ClosedDate, 3),
			TKT.TicketNumber,
			TAVG.DaysToClose,
			TAVG.Hours
		ORDER BY Yr, Mth
	END
	--combos
	ELSE IF @ucnt > 0 AND @pcnt > 0 AND @scnt < 1
	BEGIN
		SELECT DISTINCT TOP (100) PERCENT 
			dbo.FormatDateWithoutTime(TAVG.ClosedDate, 3) AS DateId, 
			YEAR(TAVG.ClosedDate) AS Yr, 
			MONTH(TAVG.ClosedDate) AS Mth, 
			COUNT(TAVG.TicketId) AS NumberofTickets, 
			TAVG.DaysToClose AS AverageDaysToClose, 
			TAVG.Hours AS AverageHours,
			TKT.TicketNumber
		FROM TICKET AS TKT
			INNER JOIN dbo.vwENET_TICKET_ASSIGNMENTCloseAverages AS TAVG
			ON TKT.TicketId = TAVG.TicketId
			INNER JOIN TECHNICIAN
			ON TAVG.AssignedTo = TECHNICIAN.UserId
		WHERE TAVG.ClosedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
			AND TAVG.AssignedTo IN 
				(SELECT UserId FROM sessTECH_LIST 
					WHERE CreatedBy = @tech)
			AND TKT.ProblemTypeId IN
				(SELECT ProblemTypeId FROM sessPROBLEM_TYPE
					WHERE CreatedBy = @tech)
		GROUP BY YEAR(TAVG.ClosedDate), 
			MONTH(TAVG.ClosedDate), 
			dbo.FormatDateWithoutTime(TAVG.ClosedDate, 3),
			TKT.TicketNumber,
			TAVG.DaysToClose,
			TAVG.Hours
		ORDER BY Yr, Mth
	END
	ELSE IF @ucnt > 0 AND @pcnt < 1 AND @scnt > 0
	BEGIN
		SELECT DISTINCT TOP (100) PERCENT 
			dbo.FormatDateWithoutTime(TAVG.ClosedDate, 3) AS DateId, 
			YEAR(TAVG.ClosedDate) AS Yr, 
			MONTH(TAVG.ClosedDate) AS Mth, 
			COUNT(TAVG.TicketId) AS NumberofTickets, 
			TAVG.DaysToClose AS AverageDaysToClose, 
			TAVG.Hours AS AverageHours,
			TKT.TicketNumber
		FROM TICKET AS TKT
			INNER JOIN dbo.vwENET_TICKET_ASSIGNMENTCloseAverages AS TAVG
			ON TKT.TicketId = TAVG.TicketId
			INNER JOIN TECHNICIAN
			ON TAVG.AssignedTo = TECHNICIAN.UserId
		WHERE TAVG.ClosedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
			AND TAVG.AssignedTo IN 
				(SELECT UserId FROM sessTECH_LIST 
					WHERE CreatedBy = @tech)
			AND TKT.SystemNameId IN
				(SELECT SystemTypeId FROM sessSYSTEM_TYPE
					WHERE CreatedBy = @tech)
		GROUP BY YEAR(TAVG.ClosedDate), 
			MONTH(TAVG.ClosedDate), 
			dbo.FormatDateWithoutTime(TAVG.ClosedDate, 3),
			TKT.TicketNumber,
			TAVG.DaysToClose,
			TAVG.Hours
		ORDER BY Yr, Mth
	END
	ELSE IF @ucnt < 1 AND @pcnt > 0 AND @scnt > 0
	BEGIN
		SELECT DISTINCT TOP (100) PERCENT 
			dbo.FormatDateWithoutTime(TAVG.ClosedDate, 3) AS DateId, 
			YEAR(TAVG.ClosedDate) AS Yr, 
			MONTH(TAVG.ClosedDate) AS Mth, 
			COUNT(TAVG.TicketId) AS NumberofTickets, 
			TAVG.DaysToClose AS AverageDaysToClose, 
			TAVG.Hours AS AverageHours,
			TKT.TicketNumber
		FROM TICKET AS TKT
			INNER JOIN dbo.vwENET_TICKET_ASSIGNMENTCloseAverages AS TAVG
			ON TKT.TicketId = TAVG.TicketId
			INNER JOIN TECHNICIAN
			ON TAVG.AssignedTo = TECHNICIAN.UserId
		WHERE TAVG.ClosedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
			AND TKT.ProblemTypeId IN
				(SELECT ProblemTypeId FROM sessPROBLEM_TYPE
					WHERE CreatedBy = @tech)
			AND TKT.SystemNameId IN
				(SELECT SystemTypeId FROM sessSYSTEM_TYPE
					WHERE CreatedBy = @tech)
		GROUP BY YEAR(TAVG.ClosedDate), 
			MONTH(TAVG.ClosedDate), 
			dbo.FormatDateWithoutTime(TAVG.ClosedDate, 3),
			TKT.TicketNumber,
			TAVG.DaysToClose,
			TAVG.Hours
		ORDER BY Yr, Mth
	END
	--end combos
	ELSE IF @ucnt > 0 AND @pcnt > 0 AND @scnt > 0
	BEGIN
		SELECT DISTINCT TOP (100) PERCENT 
			dbo.FormatDateWithoutTime(TAVG.ClosedDate, 3) AS DateId, 
			YEAR(TAVG.ClosedDate) AS Yr, 
			MONTH(TAVG.ClosedDate) AS Mth, 
			COUNT(TAVG.TicketId) AS NumberofTickets, 
			TAVG.DaysToClose AS AverageDaysToClose, 
			TAVG.Hours AS AverageHours,
			TKT.TicketNumber
		FROM TICKET AS TKT
			INNER JOIN dbo.vwENET_TICKET_ASSIGNMENTCloseAverages AS TAVG
			ON TKT.TicketId = TAVG.TicketId
			INNER JOIN TECHNICIAN
			ON TAVG.AssignedTo = TECHNICIAN.UserId
		WHERE TAVG.ClosedDate BETWEEN @sdate AND dbo.EndOfDay(@edate)
			AND TAVG.AssignedTo IN 
				(SELECT UserId FROM sessTECH_LIST 
					WHERE CreatedBy = @tech)
			AND TKT.ProblemTypeId IN
				(SELECT ProblemTypeId FROM sessPROBLEM_TYPE
					WHERE CreatedBy = @tech)
			AND TKT.SystemNameId IN
				(SELECT SystemTypeId FROM sessSYSTEM_TYPE
					WHERE CreatedBy = @tech)
		GROUP BY YEAR(TAVG.ClosedDate), 
			MONTH(TAVG.ClosedDate), 
			dbo.FormatDateWithoutTime(TAVG.ClosedDate, 3),
			TKT.TicketNumber,
			TAVG.DaysToClose,
			TAVG.Hours
		ORDER BY Yr, Mth
	END
END

