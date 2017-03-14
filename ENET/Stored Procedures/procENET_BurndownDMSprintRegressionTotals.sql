-- =============================================
-- Author:		K. Sean Kern
-- Create date: 2008-07-15
-- Description:	Creates Scrum Burndown Stat Totals
-- =============================================
create PROCEDURE [dbo].[procENET_BurndownDMSprintRegressionTotals]
(
	@sdate datetime,
	@edate datetime
)	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT     
		SUM(REG.HoursCompleted - REG.ActualHours) AS CompletedMinusActual, 
		SUM(REG.HoursRemaining - REG.ActualHours) AS RemainingMinusActual, 
		REG.SessionKey, 
		REG.SprintCycleId, 
		SUM(REG.EstimatedHours) AS EstimatedHours, 
		SUM(REG.HoursRemaining) AS HoursRemaining, 
		SUM(REG.HoursCompleted) AS HoursCompleted, 
		SUM(REG.ActualHours) AS ActualHours, 
		SUM(REG.SprintHoursRemaining) AS SprintHoursRemaining, 
		SUM(REG.SprintHoursCompleted) AS SprintHoursCompleted, 
		SUM(REG.SprintActualHours) AS SprintActualHours, 
		SUM(REG.EstimatedHoursChange) AS EstimatedHoursChange, 
		SUM(REG.CompletedHoursChange) AS CompletedHoursChange, 
		CAST(MONTH(SC.EndDate) AS varchar(2)) 
			+ '/' 
			+ CAST(DAY(SC.EndDate) AS varchar(2)) 
			+ '/' 
			+ CAST(YEAR(SC.EndDate) AS varchar(4)) AS EndDate, 
		SUM(REG.Gap) AS Gap, DATEDIFF(d, GETDATE(), SC.EndDate) AS Interval
FROM DM_SPRINT_REGRESSION AS REG 
	INNER JOIN vwENET_SPRINT_CYCLE AS SC 
	ON REG.SprintCycleId = SC.SprintCycleId
WHERE     (SC.BeginDate BETWEEN '1/1/2006' AND GETDATE())
GROUP BY REG.SessionKey, REG.SprintCycleId, SC.EndDate
ORDER BY REG.SprintCycleId
END

