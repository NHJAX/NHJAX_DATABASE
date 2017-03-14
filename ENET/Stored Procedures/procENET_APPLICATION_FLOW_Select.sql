-- =============================================
-- Author:		K. Sean Kern
-- Create date: 2008-05-30
-- Description:	APPLICATION_FLOW Select
-- 5: AWARDS
-- 17: PEER REVIEW
-- 21: CIAO
-- 29: LEAVE
-- =============================================
CREATE PROCEDURE [dbo].[procENET_APPLICATION_FLOW_Select]
(
	@gp int,
	@id bigint
)
AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON;

IF @gp = 5
BEGIN
SELECT     
	FLOW.AppFlowId, 
	FLOW.AwardId, 
	FLOW.AssignmentId, 
	FLOW.CreatedDate, 
	FLOW.UpdatedDate, 
	ISNULL(FLOW.UpdatedBy, 0) AS UpdatedBy, 
	FLOW.AwardStatusId, 
	FLOW.Comments, 
	STAT.StatusDesc, 
	ISNULL(TECH.ULName, 'Pending') AS ULName, 
	TECH.Suffix,
	TECH.UFName, 
	TECH.UMName, 
	GRP.FlowStep,
	@gp AS SecurityGroupId
FROM vwAWARDS_APPLICATION_FLOW AS FLOW 
	INNER JOIN vwAWARDS_STATUS AS STAT 
	ON FLOW.AwardStatusId = STAT.AwardStatusID 
	INNER JOIN AUDIENCE_GROUP AS GRP 
	ON FLOW.AssignmentId = GRP.AudienceId 
	LEFT OUTER JOIN TECHNICIAN AS TECH 
	ON FLOW.UpdatedBy = TECH.UserId
WHERE     (FLOW.AwardId = @id) 
	AND (GRP.GroupId = @gp)
ORDER BY FLOW.CreatedDate, 
	GRP.FlowStep
END

/*
ELSE IF @gp = 17
BEGIN
SELECT     
	ApplicationFlowId, 
	PeerReviewId, 
	AssignmentId, 
	CreatedDate, 
	UpdatedDate, 
	UpdatedBy, 
	LeaveFlowStatusId, 
	ApproverComments,
	CASE ISNULL(AF.StepDate, '1/1/1900') 
		WHEN '1/1/1900' THEN 'Pending' 
		ELSE 'Approved' 
	END AS Status,
	@gp AS SecurityGroupId
FROM	vwPR_APPLICATION_FLOW
WHERE	(LeaveRequestId = @id)
END
*/

ELSE IF @gp = 21
BEGIN
SELECT     
	FLOW.PersonnelCheckinId, 
	FLOW.PersonnelId, 
	FLOW.AudienceId, 
	FLOW.CreatedDate, 
	FLOW.UpdatedDate, 
	ISNULL(FLOW.UpdatedBy, 0) AS UpdatedBy, 
	FLOW.CheckinStatusId, 
	'' AS Comments, 
	STAT.CheckInStatusDesc, 
	ISNULL(TECH.ULName, 'Pending') AS ULName, 
	TECH.Suffix,
	TECH.UFName, 
	TECH.UMName, 
	GRP.FlowStep,
	@gp AS SecurityGroupId
FROM vwCHECKIN_APPLICATION_FLOW AS FLOW 
	INNER JOIN vwCHECKIN_STATUS AS STAT 
	ON FLOW.CheckInStatusId = STAT.CheckInStatusId 
	INNER JOIN AUDIENCE_GROUP AS GRP 
	ON FLOW.AudienceId = GRP.AudienceId 
	LEFT OUTER JOIN TECHNICIAN AS TECH 
	ON FLOW.UpdatedBy = TECH.UserId
WHERE     (GRP.GroupId = @gp) 
	AND (FLOW.PersonnelId = @id)
ORDER BY FLOW.CreatedDate, 
	GRP.FlowStep
END

ELSE IF @gp = 29
BEGIN
SELECT     
	FLOW.LeaveFlowId, 
	FLOW.LeaveRequestId, 
	FLOW.AssignmentId, 
	FLOW.CreatedDate, 
	FLOW.UpdatedDate, 
	ISNULL(FLOW.UpdatedBy, 0) AS UpdatedBy, 
	FLOW.LeaveStatusId, 
	FLOW.Comments, 
	STAT.LeaveStatusDesc, 
	ISNULL(TECH.ULName, 'Pending') AS ULName, 
	TECH.Suffix,
	TECH.UFName, 
	TECH.UMName, 
	GRP.FlowStep,
	@gp AS SecurityGroupId
FROM vwLEAVE_APPLICATION_FLOW AS FLOW 
	INNER JOIN vwLEAVE_STATUS AS STAT 
	ON FLOW.LeaveStatusId = STAT.LeaveStatusId 
	INNER JOIN AUDIENCE_GROUP AS GRP 
	ON FLOW.AssignmentId = GRP.AudienceId 
	LEFT OUTER JOIN TECHNICIAN AS TECH 
	ON FLOW.UpdatedBy = TECH.UserId
WHERE     (GRP.GroupId = @gp) 
	AND (FLOW.LeaveRequestId = @id)
ORDER BY FLOW.CreatedDate, 
	GRP.FlowStep
END

END

