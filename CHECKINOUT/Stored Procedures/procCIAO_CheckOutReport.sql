CREATE PROCEDURE [dbo].[procCIAO_CheckOutReport]
(
	@StartDate	smalldatetime,
	@EndDate	smalldatetime,
	@sort		varchar(100),
	@dir		varchar(4)
)
WITH RECOMPILE 
AS

IF @sort = 'FirstName' AND @dir = 'asc'
BEGIN
SELECT DISTINCT 
	TECH.ULName AS LastName, 
	TECH.UFName AS FirstName, 
	TECH.UMName AS MI, 
	TECH.SSN, 
	ISNULL(DESG.DesignationDesc, '') AS Status, 
	BASE.BaseName AS Location, 
	ISNULL(SCH.CheckOutDate, CO.dtChkOut) AS ScheduledCheckOutDate, 
	CO.dtChkOut AS ActualCheckOutDate,
	TECH.DoDEDI
FROM vwENET_TECHNICIAN AS TECH 
	INNER JOIN CheckOut AS CO 
	ON TECH.UserId = CO.UserId 
	INNER JOIN vwENET_BASE AS BASE 
	ON TECH.BaseId = BASE.BaseId 
	LEFT OUTER JOIN vwENET_DESIGNATION AS DESG 
	ON TECH.DesignationId = DESG.DesignationId 
	LEFT OUTER JOIN ScheduledToCheckOut AS SCH 
	ON CO.UserId = SCH.UserId
WHERE (CO.dtChkOut 
	BETWEEN dbo.StartOfDay(@startdate) 
	AND dbo.EndOfDay(@enddate))

UNION

SELECT DISTINCT 
	TECH.ULName AS LastName, 
	TECH.UFName AS FirstName, 
	TECH.UMName AS MI, 
	TECH.SSN, 
	ISNULL(DESG.DesignationDesc, '') AS Status, 
	BASE.BaseName AS Location, 
	SCH.CheckOutDate AS ScheduledCheckOutDate, 
	ISNULL(SCH.CheckedOut, '1/1/1776') AS ActualCheckOutDate,
	TECH.DoDEDI
FROM vwENET_TECHNICIAN AS TECH 
	INNER JOIN vwENET_BASE AS BASE 
	ON TECH.BaseId = BASE.BaseId 
	INNER JOIN ScheduledToCheckOut AS SCH 
	ON TECH.UserId = SCH.UserId 
	LEFT OUTER JOIN vwENET_DESIGNATION AS DESG 
	ON TECH.DesignationId = DESG.DesignationId
WHERE (SCH.CheckOutDate 
	BETWEEN dbo.StartOfDay(@startdate) 
	AND dbo.EndOfDay(@enddate)) 
	AND (SCH.UserId NOT IN
		(
		SELECT
			UserId
		FROM CheckOut
		WHERE (dtChkOut 
			BETWEEN dbo.StartOfDay(@startdate) 
			AND dbo.EndOfDay(@enddate))))

ORDER BY FirstName, LastName	
END

ELSE IF @sort = 'FirstName' AND @dir = 'desc'
BEGIN
SELECT DISTINCT 
	TECH.ULName AS LastName, 
	TECH.UFName AS FirstName, 
	TECH.UMName AS MI, 
	TECH.SSN, 
	ISNULL(DESG.DesignationDesc, '') AS Status, 
	BASE.BaseName AS Location, 
	ISNULL(SCH.CheckOutDate, CO.dtChkOut)  AS ScheduledCheckOutDate, 
	CO.dtChkOut AS ActualCheckOutDate,
	TECH.DoDEDI
FROM vwENET_TECHNICIAN AS TECH 
	INNER JOIN CheckOut AS CO 
	ON TECH.UserId = CO.UserId 
	INNER JOIN vwENET_BASE AS BASE 
	ON TECH.BaseId = BASE.BaseId 
	LEFT OUTER JOIN vwENET_DESIGNATION AS DESG 
	ON TECH.DesignationId = DESG.DesignationId 
	LEFT OUTER JOIN ScheduledToCheckOut AS SCH 
	ON CO.UserId = SCH.UserId
WHERE (CO.dtChkOut 
	BETWEEN dbo.StartOfDay(@startdate) 
	AND dbo.EndOfDay(@enddate))

UNION

SELECT DISTINCT 
	TECH.ULName AS LastName, 
	TECH.UFName AS FirstName, 
	TECH.UMName AS MI, 
	TECH.SSN, 
	ISNULL(DESG.DesignationDesc, '') AS Status, 
	BASE.BaseName AS Location, 
	SCH.CheckOutDate AS ScheduledCheckOutDate, 
	ISNULL(SCH.CheckedOut, '1/1/1776') AS ActualCheckOutDate,
	TECH.DoDEDI
FROM vwENET_TECHNICIAN AS TECH 
	INNER JOIN vwENET_BASE AS BASE 
	ON TECH.BaseId = BASE.BaseId 
	INNER JOIN ScheduledToCheckOut AS SCH 
	ON TECH.UserId = SCH.UserId 
	LEFT OUTER JOIN vwENET_DESIGNATION AS DESG 
	ON TECH.DesignationId = DESG.DesignationId
WHERE (SCH.CheckOutDate 
	BETWEEN dbo.StartOfDay(@startdate) 
	AND dbo.EndOfDay(@enddate)) 
	AND (SCH.UserId NOT IN
		(
		SELECT
			UserId
		FROM CheckOut
		WHERE (dtChkOut 
			BETWEEN dbo.StartOfDay(@startdate) 
			AND dbo.EndOfDay(@enddate))))

ORDER BY FirstName DESC, LastName DESC
END

--SSN
IF @sort = 'SSN' AND @dir = 'asc'
BEGIN
SELECT DISTINCT 
	TECH.ULName AS LastName, 
	TECH.UFName AS FirstName, 
	TECH.UMName AS MI, 
	TECH.SSN, 
	ISNULL(DESG.DesignationDesc, '') AS Status, 
	BASE.BaseName AS Location, 
	ISNULL(SCH.CheckOutDate, CO.dtChkOut) AS ScheduledCheckOutDate, 
	CO.dtChkOut AS ActualCheckOutDate,
	TECH.DoDEDI
FROM vwENET_TECHNICIAN AS TECH 
	INNER JOIN CheckOut AS CO 
	ON TECH.UserId = CO.UserId 
	INNER JOIN vwENET_BASE AS BASE 
	ON TECH.BaseId = BASE.BaseId 
	LEFT OUTER JOIN vwENET_DESIGNATION AS DESG 
	ON TECH.DesignationId = DESG.DesignationId 
	LEFT OUTER JOIN ScheduledToCheckOut AS SCH 
	ON CO.UserId = SCH.UserId
WHERE (CO.dtChkOut 
	BETWEEN dbo.StartOfDay(@startdate) 
	AND dbo.EndOfDay(@enddate))

UNION

SELECT DISTINCT 
	TECH.ULName AS LastName, 
	TECH.UFName AS FirstName, 
	TECH.UMName AS MI, 
	TECH.SSN, 
	ISNULL(DESG.DesignationDesc, '') AS Status, 
	BASE.BaseName AS Location, 
	SCH.CheckOutDate AS ScheduledCheckOutDate, 
	ISNULL(SCH.CheckedOut, '1/1/1776') AS ActualCheckOutDate,
	TECH.DoDEDI
FROM vwENET_TECHNICIAN AS TECH 
	INNER JOIN vwENET_BASE AS BASE 
	ON TECH.BaseId = BASE.BaseId 
	INNER JOIN ScheduledToCheckOut AS SCH 
	ON TECH.UserId = SCH.UserId 
	LEFT OUTER JOIN vwENET_DESIGNATION AS DESG 
	ON TECH.DesignationId = DESG.DesignationId
WHERE (SCH.CheckOutDate 
	BETWEEN dbo.StartOfDay(@startdate) 
	AND dbo.EndOfDay(@enddate)) 
	AND (SCH.UserId NOT IN
		(
		SELECT
			UserId
		FROM CheckOut
		WHERE (dtChkOut 
			BETWEEN dbo.StartOfDay(@startdate) 
			AND dbo.EndOfDay(@enddate))))

ORDER BY TECH.SSN	
END

ELSE IF @sort = 'SSN' AND @dir = 'desc'
BEGIN
SELECT DISTINCT 
	TECH.ULName AS LastName, 
	TECH.UFName AS FirstName, 
	TECH.UMName AS MI, 
	TECH.SSN, 
	ISNULL(DESG.DesignationDesc, '') AS Status, 
	BASE.BaseName AS Location, 
	ISNULL(SCH.CheckOutDate, CO.dtChkOut) AS ScheduledCheckOutDate, 
	CO.dtChkOut AS ActualCheckOutDate,
	TECH.DoDEDI
FROM vwENET_TECHNICIAN AS TECH 
	INNER JOIN CheckOut AS CO 
	ON TECH.UserId = CO.UserId 
	INNER JOIN vwENET_BASE AS BASE 
	ON TECH.BaseId = BASE.BaseId 
	LEFT OUTER JOIN vwENET_DESIGNATION AS DESG 
	ON TECH.DesignationId = DESG.DesignationId 
	LEFT OUTER JOIN ScheduledToCheckOut AS SCH 
	ON CO.UserId = SCH.UserId
WHERE (CO.dtChkOut 
	BETWEEN dbo.StartOfDay(@startdate) 
	AND dbo.EndOfDay(@enddate))

UNION

SELECT DISTINCT 
	TECH.ULName AS LastName, 
	TECH.UFName AS FirstName, 
	TECH.UMName AS MI, 
	TECH.SSN, 
	ISNULL(DESG.DesignationDesc, '') AS Status, 
	BASE.BaseName AS Location, 
	SCH.CheckOutDate AS ScheduledCheckOutDate, 
	ISNULL(SCH.CheckedOut, '1/1/1776') AS ActualCheckOutDate,
	TECH.DoDEDI
FROM vwENET_TECHNICIAN AS TECH 
	INNER JOIN vwENET_BASE AS BASE 
	ON TECH.BaseId = BASE.BaseId 
	INNER JOIN ScheduledToCheckOut AS SCH 
	ON TECH.UserId = SCH.UserId 
	LEFT OUTER JOIN vwENET_DESIGNATION AS DESG 
	ON TECH.DesignationId = DESG.DesignationId
WHERE (SCH.CheckOutDate 
	BETWEEN dbo.StartOfDay(@startdate) 
	AND dbo.EndOfDay(@enddate)) 
	AND (SCH.UserId NOT IN
		(
		SELECT
			UserId
		FROM CheckOut
		WHERE (dtChkOut 
			BETWEEN dbo.StartOfDay(@startdate) 
			AND dbo.EndOfDay(@enddate))))

ORDER BY TECH.SSN DESC
END

--Status
IF @sort = 'Status' AND @dir = 'asc'
BEGIN
SELECT DISTINCT 
	TECH.ULName AS LastName, 
	TECH.UFName AS FirstName, 
	TECH.UMName AS MI, 
	TECH.SSN, 
	ISNULL(DESG.DesignationDesc, '') AS Status, 
	BASE.BaseName AS Location, 
	ISNULL(SCH.CheckOutDate, CO.dtChkOut) AS ScheduledCheckOutDate, 
	CO.dtChkOut AS ActualCheckOutDate,
	TECH.DoDEDI
FROM vwENET_TECHNICIAN AS TECH 
	INNER JOIN CheckOut AS CO 
	ON TECH.UserId = CO.UserId 
	INNER JOIN vwENET_BASE AS BASE 
	ON TECH.BaseId = BASE.BaseId 
	LEFT OUTER JOIN vwENET_DESIGNATION AS DESG 
	ON TECH.DesignationId = DESG.DesignationId 
	LEFT OUTER JOIN ScheduledToCheckOut AS SCH 
	ON CO.UserId = SCH.UserId
WHERE (CO.dtChkOut 
	BETWEEN dbo.StartOfDay(@startdate) 
	AND dbo.EndOfDay(@enddate))

UNION

SELECT DISTINCT 
	TECH.ULName AS LastName, 
	TECH.UFName AS FirstName, 
	TECH.UMName AS MI, 
	TECH.SSN, 
	ISNULL(DESG.DesignationDesc, '') AS Status, 
	BASE.BaseName AS Location, 
	SCH.CheckOutDate AS ScheduledCheckOutDate, 
	ISNULL(SCH.CheckedOut, '1/1/1776') AS ActualCheckOutDate,
	TECH.DoDEDI
FROM vwENET_TECHNICIAN AS TECH 
	INNER JOIN vwENET_BASE AS BASE 
	ON TECH.BaseId = BASE.BaseId 
	INNER JOIN ScheduledToCheckOut AS SCH 
	ON TECH.UserId = SCH.UserId 
	LEFT OUTER JOIN vwENET_DESIGNATION AS DESG 
	ON TECH.DesignationId = DESG.DesignationId
WHERE (SCH.CheckOutDate 
	BETWEEN dbo.StartOfDay(@startdate) 
	AND dbo.EndOfDay(@enddate)) 
	AND (SCH.UserId NOT IN
		(
		SELECT
			UserId
		FROM CheckOut
		WHERE (dtChkOut 
			BETWEEN dbo.StartOfDay(@startdate) 
			AND dbo.EndOfDay(@enddate))))

ORDER BY Status	
END

ELSE IF @sort = 'Status' AND @dir = 'desc'
BEGIN
SELECT DISTINCT 
	TECH.ULName AS LastName, 
	TECH.UFName AS FirstName, 
	TECH.UMName AS MI, 
	TECH.SSN, 
	ISNULL(DESG.DesignationDesc, '') AS Status, 
	BASE.BaseName AS Location, 
	ISNULL(SCH.CheckOutDate, CO.dtChkOut) AS ScheduledCheckOutDate, 
	CO.dtChkOut AS ActualCheckOutDate,
	TECH.DoDEDI
FROM vwENET_TECHNICIAN AS TECH 
	INNER JOIN CheckOut AS CO 
	ON TECH.UserId = CO.UserId 
	INNER JOIN vwENET_BASE AS BASE 
	ON TECH.BaseId = BASE.BaseId 
	LEFT OUTER JOIN vwENET_DESIGNATION AS DESG 
	ON TECH.DesignationId = DESG.DesignationId 
	LEFT OUTER JOIN ScheduledToCheckOut AS SCH 
	ON CO.UserId = SCH.UserId
WHERE (CO.dtChkOut 
	BETWEEN dbo.StartOfDay(@startdate) 
	AND dbo.EndOfDay(@enddate))

UNION

SELECT DISTINCT 
	TECH.ULName AS LastName, 
	TECH.UFName AS FirstName, 
	TECH.UMName AS MI, 
	TECH.SSN, 
	ISNULL(DESG.DesignationDesc, '') AS Status, 
	BASE.BaseName AS Location, 
	SCH.CheckOutDate AS ScheduledCheckOutDate, 
	ISNULL(SCH.CheckedOut, '1/1/1776') AS ActualCheckOutDate,
	TECH.DoDEDI
FROM vwENET_TECHNICIAN AS TECH 
	INNER JOIN vwENET_BASE AS BASE 
	ON TECH.BaseId = BASE.BaseId 
	INNER JOIN ScheduledToCheckOut AS SCH 
	ON TECH.UserId = SCH.UserId 
	LEFT OUTER JOIN vwENET_DESIGNATION AS DESG 
	ON TECH.DesignationId = DESG.DesignationId
WHERE (SCH.CheckOutDate 
	BETWEEN dbo.StartOfDay(@startdate) 
	AND dbo.EndOfDay(@enddate)) 
	AND (SCH.UserId NOT IN
		(
		SELECT
			UserId
		FROM CheckOut
		WHERE (dtChkOut 
			BETWEEN dbo.StartOfDay(@startdate) 
			AND dbo.EndOfDay(@enddate))))

ORDER BY Status DESC
END

--Location
IF @sort = 'Location' AND @dir = 'asc'
BEGIN
SELECT DISTINCT 
	TECH.ULName AS LastName, 
	TECH.UFName AS FirstName, 
	TECH.UMName AS MI, 
	TECH.SSN, 
	ISNULL(DESG.DesignationDesc, '') AS Status, 
	BASE.BaseName AS Location, 
	ISNULL(SCH.CheckOutDate, CO.dtChkOut) AS ScheduledCheckOutDate, 
	CO.dtChkOut AS ActualCheckOutDate,
	TECH.DoDEDI
FROM vwENET_TECHNICIAN AS TECH 
	INNER JOIN CheckOut AS CO 
	ON TECH.UserId = CO.UserId 
	INNER JOIN vwENET_BASE AS BASE 
	ON TECH.BaseId = BASE.BaseId 
	LEFT OUTER JOIN vwENET_DESIGNATION AS DESG 
	ON TECH.DesignationId = DESG.DesignationId 
	LEFT OUTER JOIN ScheduledToCheckOut AS SCH 
	ON CO.UserId = SCH.UserId
WHERE (CO.dtChkOut 
	BETWEEN dbo.StartOfDay(@startdate) 
	AND dbo.EndOfDay(@enddate))

UNION

SELECT DISTINCT 
	TECH.ULName AS LastName, 
	TECH.UFName AS FirstName, 
	TECH.UMName AS MI, 
	TECH.SSN, 
	ISNULL(DESG.DesignationDesc, '') AS Status, 
	BASE.BaseName AS Location, 
	SCH.CheckOutDate AS ScheduledCheckOutDate, 
	ISNULL(SCH.CheckedOut, '1/1/1776') AS ActualCheckOutDate,
	TECH.DoDEDI
FROM vwENET_TECHNICIAN AS TECH 
	INNER JOIN vwENET_BASE AS BASE 
	ON TECH.BaseId = BASE.BaseId 
	INNER JOIN ScheduledToCheckOut AS SCH 
	ON TECH.UserId = SCH.UserId 
	LEFT OUTER JOIN vwENET_DESIGNATION AS DESG 
	ON TECH.DesignationId = DESG.DesignationId
WHERE (SCH.CheckOutDate 
	BETWEEN dbo.StartOfDay(@startdate) 
	AND dbo.EndOfDay(@enddate)) 
	AND (SCH.UserId NOT IN
		(
		SELECT
			UserId
		FROM CheckOut
		WHERE (dtChkOut 
			BETWEEN dbo.StartOfDay(@startdate) 
			AND dbo.EndOfDay(@enddate))))

ORDER BY Location	
END

ELSE IF @sort = 'Location' AND @dir = 'desc'
BEGIN
SELECT DISTINCT 
	TECH.ULName AS LastName, 
	TECH.UFName AS FirstName, 
	TECH.UMName AS MI, 
	TECH.SSN, 
	ISNULL(DESG.DesignationDesc, '') AS Status, 
	BASE.BaseName AS Location, 
	ISNULL(SCH.CheckOutDate, CO.dtChkOut) AS ScheduledCheckOutDate, 
	CO.dtChkOut AS ActualCheckOutDate,
	TECH.DoDEDI
FROM vwENET_TECHNICIAN AS TECH 
	INNER JOIN CheckOut AS CO 
	ON TECH.UserId = CO.UserId 
	INNER JOIN vwENET_BASE AS BASE 
	ON TECH.BaseId = BASE.BaseId 
	LEFT OUTER JOIN vwENET_DESIGNATION AS DESG 
	ON TECH.DesignationId = DESG.DesignationId 
	LEFT OUTER JOIN ScheduledToCheckOut AS SCH 
	ON CO.UserId = SCH.UserId
WHERE (CO.dtChkOut 
	BETWEEN dbo.StartOfDay(@startdate) 
	AND dbo.EndOfDay(@enddate))

UNION

SELECT DISTINCT 
	TECH.ULName AS LastName, 
	TECH.UFName AS FirstName, 
	TECH.UMName AS MI, 
	TECH.SSN, 
	ISNULL(DESG.DesignationDesc, '') AS Status, 
	BASE.BaseName AS Location, 
	SCH.CheckOutDate AS ScheduledCheckOutDate, 
	ISNULL(SCH.CheckedOut, '1/1/1776') AS ActualCheckOutDate,
	TECH.DoDEDI
FROM vwENET_TECHNICIAN AS TECH 
	INNER JOIN vwENET_BASE AS BASE 
	ON TECH.BaseId = BASE.BaseId 
	INNER JOIN ScheduledToCheckOut AS SCH 
	ON TECH.UserId = SCH.UserId 
	LEFT OUTER JOIN vwENET_DESIGNATION AS DESG 
	ON TECH.DesignationId = DESG.DesignationId
WHERE (SCH.CheckOutDate 
	BETWEEN dbo.StartOfDay(@startdate) 
	AND dbo.EndOfDay(@enddate)) 
	AND (SCH.UserId NOT IN
		(
		SELECT
			UserId
		FROM CheckOut
		WHERE (dtChkOut 
			BETWEEN dbo.StartOfDay(@startdate) 
			AND dbo.EndOfDay(@enddate))))

ORDER BY Location DESC
END

--ScheduledCheckOutDate
IF @sort = 'ScheduledCheckOutDate' AND @dir = 'asc'
BEGIN
SELECT DISTINCT 
	TECH.ULName AS LastName, 
	TECH.UFName AS FirstName, 
	TECH.UMName AS MI, 
	TECH.SSN, 
	ISNULL(DESG.DesignationDesc, '') AS Status, 
	BASE.BaseName AS Location, 
	ISNULL(SCH.CheckOutDate, CO.dtChkOut) AS ScheduledCheckOutDate, 
	CO.dtChkOut AS ActualCheckOutDate,
	TECH.DoDEDI
FROM vwENET_TECHNICIAN AS TECH 
	INNER JOIN CheckOut AS CO 
	ON TECH.UserId = CO.UserId 
	INNER JOIN vwENET_BASE AS BASE 
	ON TECH.BaseId = BASE.BaseId 
	LEFT OUTER JOIN vwENET_DESIGNATION AS DESG 
	ON TECH.DesignationId = DESG.DesignationId 
	LEFT OUTER JOIN ScheduledToCheckOut AS SCH 
	ON CO.UserId = SCH.UserId
WHERE (CO.dtChkOut 
	BETWEEN dbo.StartOfDay(@startdate) 
	AND dbo.EndOfDay(@enddate))

UNION

SELECT DISTINCT 
	TECH.ULName AS LastName, 
	TECH.UFName AS FirstName, 
	TECH.UMName AS MI, 
	TECH.SSN, 
	ISNULL(DESG.DesignationDesc, '') AS Status, 
	BASE.BaseName AS Location, 
	SCH.CheckOutDate AS ScheduledCheckOutDate, 
	ISNULL(SCH.CheckedOut, '1/1/1776') AS ActualCheckOutDate,
	TECH.DoDEDI
FROM vwENET_TECHNICIAN AS TECH 
	INNER JOIN vwENET_BASE AS BASE 
	ON TECH.BaseId = BASE.BaseId 
	INNER JOIN ScheduledToCheckOut AS SCH 
	ON TECH.UserId = SCH.UserId 
	LEFT OUTER JOIN vwENET_DESIGNATION AS DESG 
	ON TECH.DesignationId = DESG.DesignationId
WHERE (SCH.CheckOutDate 
	BETWEEN dbo.StartOfDay(@startdate) 
	AND dbo.EndOfDay(@enddate)) 
	AND (SCH.UserId NOT IN
		(
		SELECT
			UserId
		FROM CheckOut
		WHERE (dtChkOut 
			BETWEEN dbo.StartOfDay(@startdate) 
			AND dbo.EndOfDay(@enddate))))

ORDER BY ScheduledCheckOutDate	
END

ELSE IF @sort = 'ScheduledCheckOutDate' AND @dir = 'desc'
BEGIN
SELECT DISTINCT 
	TECH.ULName AS LastName, 
	TECH.UFName AS FirstName, 
	TECH.UMName AS MI, 
	TECH.SSN, 
	ISNULL(DESG.DesignationDesc, '') AS Status, 
	BASE.BaseName AS Location, 
	ISNULL(SCH.CheckOutDate, CO.dtChkOut) AS ScheduledCheckOutDate, 
	CO.dtChkOut AS ActualCheckOutDate,
	TECH.DoDEDI
FROM vwENET_TECHNICIAN AS TECH 
	INNER JOIN CheckOut AS CO 
	ON TECH.UserId = CO.UserId 
	INNER JOIN vwENET_BASE AS BASE 
	ON TECH.BaseId = BASE.BaseId 
	LEFT OUTER JOIN vwENET_DESIGNATION AS DESG 
	ON TECH.DesignationId = DESG.DesignationId 
	LEFT OUTER JOIN ScheduledToCheckOut AS SCH 
	ON CO.UserId = SCH.UserId
WHERE (CO.dtChkOut 
	BETWEEN dbo.StartOfDay(@startdate) 
	AND dbo.EndOfDay(@enddate))

UNION

SELECT DISTINCT 
	TECH.ULName AS LastName, 
	TECH.UFName AS FirstName, 
	TECH.UMName AS MI, 
	TECH.SSN, 
	ISNULL(DESG.DesignationDesc, '') AS Status, 
	BASE.BaseName AS Location, 
	SCH.CheckOutDate AS ScheduledCheckOutDate, 
	ISNULL(SCH.CheckedOut, '1/1/1776') AS ActualCheckOutDate,
	TECH.DoDEDI
FROM vwENET_TECHNICIAN AS TECH 
	INNER JOIN vwENET_BASE AS BASE 
	ON TECH.BaseId = BASE.BaseId 
	INNER JOIN ScheduledToCheckOut AS SCH 
	ON TECH.UserId = SCH.UserId 
	LEFT OUTER JOIN vwENET_DESIGNATION AS DESG 
	ON TECH.DesignationId = DESG.DesignationId
WHERE (SCH.CheckOutDate 
	BETWEEN dbo.StartOfDay(@startdate) 
	AND dbo.EndOfDay(@enddate)) 
	AND (SCH.UserId NOT IN
		(
		SELECT
			UserId
		FROM CheckOut
		WHERE (dtChkOut 
			BETWEEN dbo.StartOfDay(@startdate) 
			AND dbo.EndOfDay(@enddate))))

ORDER BY ScheduledCheckOutDate DESC
END

--ActualCheckOutDate
IF @sort = 'ActualCheckOutDate' AND @dir = 'asc'
BEGIN
SELECT DISTINCT 
	TECH.ULName AS LastName, 
	TECH.UFName AS FirstName, 
	TECH.UMName AS MI, 
	TECH.SSN, 
	ISNULL(DESG.DesignationDesc, '') AS Status, 
	BASE.BaseName AS Location, 
	ISNULL(SCH.CheckOutDate, CO.dtChkOut) AS ScheduledCheckOutDate, 
	CO.dtChkOut AS ActualCheckOutDate,
	TECH.DoDEDI
FROM vwENET_TECHNICIAN AS TECH 
	INNER JOIN CheckOut AS CO 
	ON TECH.UserId = CO.UserId 
	INNER JOIN vwENET_BASE AS BASE 
	ON TECH.BaseId = BASE.BaseId 
	LEFT OUTER JOIN vwENET_DESIGNATION AS DESG 
	ON TECH.DesignationId = DESG.DesignationId 
	LEFT OUTER JOIN ScheduledToCheckOut AS SCH 
	ON CO.UserId = SCH.UserId
WHERE (CO.dtChkOut 
	BETWEEN dbo.StartOfDay(@startdate) 
	AND dbo.EndOfDay(@enddate))

UNION

SELECT DISTINCT 
	TECH.ULName AS LastName, 
	TECH.UFName AS FirstName, 
	TECH.UMName AS MI, 
	TECH.SSN, 
	ISNULL(DESG.DesignationDesc, '') AS Status, 
	BASE.BaseName AS Location, 
	SCH.CheckOutDate AS ScheduledCheckOutDate, 
	ISNULL(SCH.CheckedOut, '1/1/1776') AS ActualCheckOutDate,
	TECH.DoDEDI
FROM vwENET_TECHNICIAN AS TECH 
	INNER JOIN vwENET_BASE AS BASE 
	ON TECH.BaseId = BASE.BaseId 
	INNER JOIN ScheduledToCheckOut AS SCH 
	ON TECH.UserId = SCH.UserId 
	LEFT OUTER JOIN vwENET_DESIGNATION AS DESG 
	ON TECH.DesignationId = DESG.DesignationId
WHERE (SCH.CheckOutDate 
	BETWEEN dbo.StartOfDay(@startdate) 
	AND dbo.EndOfDay(@enddate)) 
	AND (SCH.UserId NOT IN
		(
		SELECT
			UserId
		FROM CheckOut
		WHERE (dtChkOut 
			BETWEEN dbo.StartOfDay(@startdate) 
			AND dbo.EndOfDay(@enddate))))

ORDER BY ActualCheckOutDate	
END

ELSE IF @sort = 'ActualCheckOutDate' AND @dir = 'desc'
BEGIN
SELECT DISTINCT 
	TECH.ULName AS LastName, 
	TECH.UFName AS FirstName, 
	TECH.UMName AS MI, 
	TECH.SSN, 
	ISNULL(DESG.DesignationDesc, '') AS Status, 
	BASE.BaseName AS Location, 
	ISNULL(SCH.CheckOutDate, CO.dtChkOut) AS ScheduledCheckOutDate, 
	CO.dtChkOut AS ActualCheckOutDate,
	TECH.DoDEDI
FROM vwENET_TECHNICIAN AS TECH 
	INNER JOIN CheckOut AS CO 
	ON TECH.UserId = CO.UserId 
	INNER JOIN vwENET_BASE AS BASE 
	ON TECH.BaseId = BASE.BaseId 
	LEFT OUTER JOIN vwENET_DESIGNATION AS DESG 
	ON TECH.DesignationId = DESG.DesignationId 
	LEFT OUTER JOIN ScheduledToCheckOut AS SCH 
	ON CO.UserId = SCH.UserId
WHERE (CO.dtChkOut 
	BETWEEN dbo.StartOfDay(@startdate) 
	AND dbo.EndOfDay(@enddate))

UNION

SELECT DISTINCT 
	TECH.ULName AS LastName, 
	TECH.UFName AS FirstName, 
	TECH.UMName AS MI, 
	TECH.SSN, 
	ISNULL(DESG.DesignationDesc, '') AS Status, 
	BASE.BaseName AS Location, 
	SCH.CheckOutDate AS ScheduledCheckOutDate, 
	ISNULL(SCH.CheckedOut, '1/1/1776') AS ActualCheckOutDate,
	TECH.DoDEDI
FROM vwENET_TECHNICIAN AS TECH 
	INNER JOIN vwENET_BASE AS BASE 
	ON TECH.BaseId = BASE.BaseId 
	INNER JOIN ScheduledToCheckOut AS SCH 
	ON TECH.UserId = SCH.UserId 
	LEFT OUTER JOIN vwENET_DESIGNATION AS DESG 
	ON TECH.DesignationId = DESG.DesignationId
WHERE (SCH.CheckOutDate 
	BETWEEN dbo.StartOfDay(@startdate) 
	AND dbo.EndOfDay(@enddate)) 
	AND (SCH.UserId NOT IN
		(
		SELECT
			UserId
		FROM CheckOut
		WHERE (dtChkOut 
			BETWEEN dbo.StartOfDay(@startdate) 
			AND dbo.EndOfDay(@enddate))))

ORDER BY ActualCheckOutDate DESC
END

--LastName Default
IF @sort = 'LastName' AND @dir = 'desc'
BEGIN
SELECT DISTINCT 
	TECH.ULName AS LastName, 
	TECH.UFName AS FirstName, 
	TECH.UMName AS MI, 
	TECH.SSN, 
	ISNULL(DESG.DesignationDesc, '') AS Status, 
	BASE.BaseName AS Location, 
	ISNULL(SCH.CheckOutDate, CO.dtChkOut) AS ScheduledCheckOutDate, 
	CO.dtChkOut AS ActualCheckOutDate,
	TECH.DoDEDI
FROM vwENET_TECHNICIAN AS TECH 
	INNER JOIN CheckOut AS CO 
	ON TECH.UserId = CO.UserId 
	INNER JOIN vwENET_BASE AS BASE 
	ON TECH.BaseId = BASE.BaseId 
	LEFT OUTER JOIN vwENET_DESIGNATION AS DESG 
	ON TECH.DesignationId = DESG.DesignationId 
	LEFT OUTER JOIN ScheduledToCheckOut AS SCH 
	ON CO.UserId = SCH.UserId
WHERE (CO.dtChkOut 
	BETWEEN dbo.StartOfDay(@startdate) 
	AND dbo.EndOfDay(@enddate))

UNION

SELECT DISTINCT 
	TECH.ULName AS LastName, 
	TECH.UFName AS FirstName, 
	TECH.UMName AS MI, 
	TECH.SSN, 
	ISNULL(DESG.DesignationDesc, '') AS Status, 
	BASE.BaseName AS Location, 
	SCH.CheckOutDate AS ScheduledCheckOutDate, 
	ISNULL(SCH.CheckedOut, '1/1/1776') AS ActualCheckOutDate,
	TECH.DoDEDI
FROM vwENET_TECHNICIAN AS TECH 
	INNER JOIN vwENET_BASE AS BASE 
	ON TECH.BaseId = BASE.BaseId 
	INNER JOIN ScheduledToCheckOut AS SCH 
	ON TECH.UserId = SCH.UserId 
	LEFT OUTER JOIN vwENET_DESIGNATION AS DESG 
	ON TECH.DesignationId = DESG.DesignationId
WHERE (SCH.CheckOutDate 
	BETWEEN dbo.StartOfDay(@startdate) 
	AND dbo.EndOfDay(@enddate)) 
	AND (SCH.UserId NOT IN
		(
		SELECT
			UserId
		FROM CheckOut
		WHERE (dtChkOut 
			BETWEEN dbo.StartOfDay(@startdate) 
			AND dbo.EndOfDay(@enddate))))

ORDER BY LastName DESC, FirstName DESC	
END

ELSE 
BEGIN
SELECT DISTINCT 
	TECH.ULName AS LastName, 
	TECH.UFName AS FirstName, 
	TECH.UMName AS MI, 
	TECH.SSN, 
	ISNULL(DESG.DesignationDesc, '') AS Status, 
	BASE.BaseName AS Location, 
	ISNULL(SCH.CheckOutDate, CO.dtChkOut) AS ScheduledCheckOutDate, 
	CO.dtChkOut AS ActualCheckOutDate,
	TECH.DoDEDI
FROM vwENET_TECHNICIAN AS TECH 
	INNER JOIN CheckOut AS CO 
	ON TECH.UserId = CO.UserId 
	INNER JOIN vwENET_BASE AS BASE 
	ON TECH.BaseId = BASE.BaseId 
	LEFT OUTER JOIN vwENET_DESIGNATION AS DESG 
	ON TECH.DesignationId = DESG.DesignationId 
	LEFT OUTER JOIN ScheduledToCheckOut AS SCH 
	ON CO.UserId = SCH.UserId
WHERE (CO.dtChkOut 
	BETWEEN dbo.StartOfDay(@startdate) 
	AND dbo.EndOfDay(@enddate))

UNION

SELECT DISTINCT 
	TECH.ULName AS LastName, 
	TECH.UFName AS FirstName, 
	TECH.UMName AS MI, 
	TECH.SSN, 
	ISNULL(DESG.DesignationDesc, '') AS Status, 
	BASE.BaseName AS Location, 
	SCH.CheckOutDate AS ScheduledCheckOutDate, 
	ISNULL(SCH.CheckedOut, '1/1/1776') AS ActualCheckOutDate,
	TECH.DoDEDI
FROM vwENET_TECHNICIAN AS TECH 
	INNER JOIN vwENET_BASE AS BASE 
	ON TECH.BaseId = BASE.BaseId 
	INNER JOIN ScheduledToCheckOut AS SCH 
	ON TECH.UserId = SCH.UserId 
	LEFT OUTER JOIN vwENET_DESIGNATION AS DESG 
	ON TECH.DesignationId = DESG.DesignationId
WHERE (SCH.CheckOutDate 
	BETWEEN dbo.StartOfDay(@startdate) 
	AND dbo.EndOfDay(@enddate)) 
	AND (SCH.UserId NOT IN
		(
		SELECT
			UserId
		FROM CheckOut
		WHERE (dtChkOut 
			BETWEEN dbo.StartOfDay(@startdate) 
			AND dbo.EndOfDay(@enddate))))

ORDER BY LastName, FirstName
END

--DoDEDI
IF @sort = 'DoDEDI' AND @dir = 'asc'
BEGIN
SELECT DISTINCT 
	TECH.ULName AS LastName, 
	TECH.UFName AS FirstName, 
	TECH.UMName AS MI, 
	TECH.SSN, 
	ISNULL(DESG.DesignationDesc, '') AS Status, 
	BASE.BaseName AS Location, 
	ISNULL(SCH.CheckOutDate, CO.dtChkOut) AS ScheduledCheckOutDate, 
	CO.dtChkOut AS ActualCheckOutDate,
	TECH.DoDEDI
FROM vwENET_TECHNICIAN AS TECH 
	INNER JOIN CheckOut AS CO 
	ON TECH.UserId = CO.UserId 
	INNER JOIN vwENET_BASE AS BASE 
	ON TECH.BaseId = BASE.BaseId 
	LEFT OUTER JOIN vwENET_DESIGNATION AS DESG 
	ON TECH.DesignationId = DESG.DesignationId 
	LEFT OUTER JOIN ScheduledToCheckOut AS SCH 
	ON CO.UserId = SCH.UserId
WHERE (CO.dtChkOut 
	BETWEEN dbo.StartOfDay(@startdate) 
	AND dbo.EndOfDay(@enddate))

UNION

SELECT DISTINCT 
	TECH.ULName AS LastName, 
	TECH.UFName AS FirstName, 
	TECH.UMName AS MI, 
	TECH.SSN, 
	ISNULL(DESG.DesignationDesc, '') AS Status, 
	BASE.BaseName AS Location, 
	SCH.CheckOutDate AS ScheduledCheckOutDate, 
	ISNULL(SCH.CheckedOut, '1/1/1776') AS ActualCheckOutDate,
	TECH.DoDEDI
FROM vwENET_TECHNICIAN AS TECH 
	INNER JOIN vwENET_BASE AS BASE 
	ON TECH.BaseId = BASE.BaseId 
	INNER JOIN ScheduledToCheckOut AS SCH 
	ON TECH.UserId = SCH.UserId 
	LEFT OUTER JOIN vwENET_DESIGNATION AS DESG 
	ON TECH.DesignationId = DESG.DesignationId
WHERE (SCH.CheckOutDate 
	BETWEEN dbo.StartOfDay(@startdate) 
	AND dbo.EndOfDay(@enddate)) 
	AND (SCH.UserId NOT IN
		(
		SELECT
			UserId
		FROM CheckOut
		WHERE (dtChkOut 
			BETWEEN dbo.StartOfDay(@startdate) 
			AND dbo.EndOfDay(@enddate))))

ORDER BY TECH.DoDEDI	
END

ELSE IF @sort = 'DoDEDI' AND @dir = 'desc'
BEGIN
SELECT DISTINCT 
	TECH.ULName AS LastName, 
	TECH.UFName AS FirstName, 
	TECH.UMName AS MI, 
	TECH.SSN, 
	ISNULL(DESG.DesignationDesc, '') AS Status, 
	BASE.BaseName AS Location, 
	ISNULL(SCH.CheckOutDate, CO.dtChkOut) AS ScheduledCheckOutDate, 
	CO.dtChkOut AS ActualCheckOutDate,
	TECH.DoDEDI
FROM vwENET_TECHNICIAN AS TECH 
	INNER JOIN CheckOut AS CO 
	ON TECH.UserId = CO.UserId 
	INNER JOIN vwENET_BASE AS BASE 
	ON TECH.BaseId = BASE.BaseId 
	LEFT OUTER JOIN vwENET_DESIGNATION AS DESG 
	ON TECH.DesignationId = DESG.DesignationId 
	LEFT OUTER JOIN ScheduledToCheckOut AS SCH 
	ON CO.UserId = SCH.UserId
WHERE (CO.dtChkOut 
	BETWEEN dbo.StartOfDay(@startdate) 
	AND dbo.EndOfDay(@enddate))

UNION

SELECT DISTINCT 
	TECH.ULName AS LastName, 
	TECH.UFName AS FirstName, 
	TECH.UMName AS MI, 
	TECH.SSN, 
	ISNULL(DESG.DesignationDesc, '') AS Status, 
	BASE.BaseName AS Location, 
	SCH.CheckOutDate AS ScheduledCheckOutDate, 
	ISNULL(SCH.CheckedOut, '1/1/1776') AS ActualCheckOutDate,
	TECH.DoDEDI
FROM vwENET_TECHNICIAN AS TECH 
	INNER JOIN vwENET_BASE AS BASE 
	ON TECH.BaseId = BASE.BaseId 
	INNER JOIN ScheduledToCheckOut AS SCH 
	ON TECH.UserId = SCH.UserId 
	LEFT OUTER JOIN vwENET_DESIGNATION AS DESG 
	ON TECH.DesignationId = DESG.DesignationId
WHERE (SCH.CheckOutDate 
	BETWEEN dbo.StartOfDay(@startdate) 
	AND dbo.EndOfDay(@enddate)) 
	AND (SCH.UserId NOT IN
		(
		SELECT
			UserId
		FROM CheckOut
		WHERE (dtChkOut 
			BETWEEN dbo.StartOfDay(@startdate) 
			AND dbo.EndOfDay(@enddate))))

ORDER BY TECH.DoDEDI DESC
END

