-- =============================================
-- Author:		Robert E Evans
-- Create date: 24 June 2011
-- Description:	Enet Ticket Report Grouped By Dept
-- =============================================
CREATE PROCEDURE [dbo].[ENET_REPORT_TicketsByDept] 
	@StatusId int=0,
	@DepartmentId int=0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
IF @StatusId = 0
	BEGIN
		SELECT T.[TicketId]
			  ,T.[TicketNumber]
			  ,PT.[ProblemTypeDesc]
			  ,ST.[SystemDesc]
			  ,CASE WHEN T.[PatientImpact] = 1 THEN 'Yes' ELSE 'No' END as PatientImpact
			  ,SN.[SoftwareDesc]
			  ,DP.[DCBILLET]
			  ,T.[Comments]
			  ,TS.[StatusDesc]
			  ,T.[CustomerName]
			  ,T.[OpenDate]
			  ,T.[PriorityId]
			  ,T.[EstimatedHours]
			  ,T.[AudienceId]
			  ,AU.[DisplayName]
			  ,T.[CreatedBy]
			  ,TA.[Remarks] as 'TicketAssignmentRemarks'
			  ,TN.[ULNAME] + ', ' + TN.[UFName] + ' ' + TN.[UMName]
			  ,CONVERT(CHAR(12),TA.[AssignmentDate],101) as 'AssignedDate'
		  FROM [TICKET] as T
		  INNER JOIN [TICKET_STATUS] as TS ON TS.[StatusId] = T.[StatusId]
		INNER JOIN [TICKET_ASSIGNMENT] as TA ON TA.[TicketId] = T.[TicketId]
		INNER JOIN [TECHNICIAN] as TN ON TN.[UserId] = TA.[AssignedTo]
		INNER JOIN [SYSTEM_TYPE] as ST ON ST.[SystemId] = T.[SystemNameId]
		INNER JOIN [PROBLEM_TYPE] as PT ON PT.[ProblemTypeId] = T.[ProblemTypeId]
		INNER JOIN [SOFTWARE_NAME] as SN ON SN.[SoftwareId] = T.[SoftwareId]
		INNER JOIN [DEPARTMENT_20080612] as DP ON DP.[DepartmentId] = T.[DepartmentId]
			AND DP.[DepartmentId] = CASE WHEN @DepartmentId = 0 THEN DP.[DepartmentId] ELSE @DepartmentID END
		LEFT JOIN [AUDIENCE]as AU ON AU.[AudienceId] = T.[AudienceId]
		ORDER BY DP.[DCBILLET],ST.[SystemDesc],T.[TicketNumber]
	END
ELSE
	BEGIN
		SELECT T.[TicketId]
			  ,T.[TicketNumber]
			  ,PT.[ProblemTypeDesc]
			  ,ST.[SystemDesc]
			  ,CASE WHEN T.[PatientImpact] = 1 THEN 'Yes' ELSE 'No' END as PatientImpact
			  ,SN.[SoftwareDesc]
			  ,DP.[DCBILLET]
			  ,T.[Comments]
			  ,TS.[StatusDesc]
			  ,T.[CustomerName]
			  ,T.[OpenDate]
			  ,T.[PriorityId]
			  ,T.[EstimatedHours]
			  ,T.[AudienceId]
			  ,AU.[DisplayName]
			  ,T.[CreatedBy]
			  ,TA.[Remarks] as 'TicketAssignmentRemarks'
			  ,TN.[ULNAME] + ', ' + TN.[UFName] + ' ' + TN.[UMName]
			  ,CONVERT(CHAR(12),TA.[AssignmentDate],101) as 'AssignedDate'
		  FROM [TICKET] as T
		  INNER JOIN [TICKET_STATUS] as TS ON TS.[StatusId] = T.[StatusId]
		INNER JOIN [TICKET_ASSIGNMENT] as TA ON TA.[TicketId] = T.[TicketId]
		INNER JOIN [TECHNICIAN] as TN ON TN.[UserId] = TA.[AssignedTo]
		INNER JOIN [SYSTEM_TYPE] as ST ON ST.[SystemId] = T.[SystemNameId]
		INNER JOIN [PROBLEM_TYPE] as PT ON PT.[ProblemTypeId] = T.[ProblemTypeId]
		INNER JOIN [SOFTWARE_NAME] as SN ON SN.[SoftwareId] = T.[SoftwareId]
		INNER JOIN [DEPARTMENT_20080612] as DP ON DP.[DepartmentId] = T.[DepartmentId]
			AND DP.[DepartmentId] = CASE WHEN @DepartmentId = 0 THEN DP.[DepartmentId] ELSE @DepartmentID END
		LEFT JOIN [AUDIENCE]as AU ON AU.[AudienceId] = T.[AudienceId]
		WHERE T.StatusId = @StatusId
		ORDER BY DP.[DCBILLET],ST.[SystemDesc],T.[TicketNumber]
	END
END

