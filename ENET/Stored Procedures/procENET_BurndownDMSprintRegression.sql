-- =============================================
-- Author:		K. Sean Kern
-- Create date: 2008-07-15
-- Description:	Creates Scrum Burndown Stat Totals
-- =============================================
CREATE PROCEDURE [dbo].[procENET_BurndownDMSprintRegression]
(
	@sys int,
	@sdate datetime,
	@edate datetime
)	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT     
		REG.HoursCompleted - REG.ActualHours AS Expr1, 
		REG.HoursRemaining - REG.ActualHours AS Expr2, 
		REG.SessionKey, 
		REG.SprintCycleId, 
		REG.CreatedDate, 
		REG.EstimatedHours, 
		REG.HoursRemaining, 
		REG.HoursCompleted, 
		REG.ActualHours, 
		REG.SprintHoursRemaining, 
		REG.SprintHoursCompleted, 
		REG.SprintActualHours, 
		REG.EstimatedHoursChange, 
		REG.CompletedHoursChange,
		CAST(MONTH(SC.EndDate) AS varchar(2)) + '/' + CAST(DAY(SC.EndDate) AS varchar(2)) + '/' + CAST(YEAR(SC.EndDate) AS varchar(4)) AS EndDate,
		REG.Gap,
		DATEDIFF(d,getdate(),SC.EndDate) AS Interval
	FROM DM_SPRINT_REGRESSION AS REG
	INNER JOIN dbo.vwENET_SPRINT_CYCLE AS SC
	ON REG.SprintCycleId = SC.SprintCycleId
	WHERE REG.SystemId = @sys
	AND SC.BeginDate BETWEEN @sdate AND @edate
	ORDER BY REG.SprintCycleId
END

