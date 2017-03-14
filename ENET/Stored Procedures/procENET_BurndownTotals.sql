-- =============================================
-- Author:		K. Sean Kern
-- Create date: 2008-07-11
-- Description:	Creates Scrum Burndown Stat Totals
-- =============================================
CREATE PROCEDURE [dbo].[procENET_BurndownTotals]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT
		BURN.SystemId, 
		BURN.SystemDesc, 
		ISNULL(TOT.TotalCount, 0) AS TotalCount, 
		ISNULL(TOT.TotalEstimatedHours, 0) AS TotalEstimatedHours, 
		ISNULL(EST.OpenEstimatedCount, 0) AS OpenEstimatedCount, 
		ISNULL(EST.OpenEstimatedHours, 0) AS OpenEstimatedHours, 
		ISNULL(TOT.TotalEstimatedHours,0) - ISNULL(EST.OpenEstimatedHours,0) As EstimatedRemainingHours,
		ISNULL(ACT.ActualHours, 0) AS ActualHours,
		ISNULL(TOT.TotalEstimatedHours,0) - ISNULL(ACT.ActualHours,0) As ActualRemainingHours,
		CASE (ISNULL(TOT.TotalEstimatedHours,0) - ISNULL(EST.OpenEstimatedHours,0))	
			WHEN 0 THEN 0
		ELSE
			(ISNULL(TOT.TotalEstimatedHours,0) - ISNULL(ACT.ActualHours,0))/(ISNULL(TOT.TotalEstimatedHours,0) - ISNULL(EST.OpenEstimatedHours,0)) 
		END AS EfficiencyPercentage,
		isnull(CASE isnull(TotalEstimatedHours, 0) 
			WHEN 0 THEN 0 
			ELSE OpenEstimatedHours / TotalEstimatedHours 
		END,0) AS PercentProjectRemaining, 
		isnull(CASE IsNull(ActualHours, 0) 
			WHEN 0 THEN 0 
			ELSE (TotalEstimatedHours / ActualHours) 
		END,0) AS PercentHoursRemaining,
		ISNULL(TOT.TotalEstimatedHours - EST.OpenEstimatedHours - ACT.ActualHours, 0)/100 AS Efficiency,
		ISNULL(EST.OpenEstimatedHours, 0) - ISNULL(ACT.ActualHours, 0) AS Gap,
		EDATE.EndDate
	FROM vwENET_BurndownTotalHours AS TOT 
		RIGHT OUTER JOIN vwENET_BurndownList AS BURN 
		ON TOT.SystemNameId = BURN.SystemId 
		LEFT OUTER JOIN vwENET_BurndownOpenEstimated AS EST 
		ON BURN.SystemId = EST.SystemNameId 
		LEFT OUTER JOIN vwENET_BurndownActualHours AS ACT 
		ON BURN.SystemId = ACT.SystemNameId
		INNER JOIN vwENET_BurndownEndDate AS EDATE
		ON BURN.SystemId = EDATE.SystemId
	ORDER BY BURN.SystemDesc
END

