CREATE PROCEDURE [dbo].[upENet_TicketSelect](
	@tic		bit = 0,
	@num		varchar(50) = '',
	@debug	bit = 0
)
 AS

DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)

SELECT @sql = 'SELECT
			T.TicketNumber,
			T.TicketId,
			TECH.UFName,
			TECH.UMName,
			TECH.ULName,
			TECH1.UFName AS AFName,
			TECH1.UMName AS AMName,
			TECH1.ULName AS ALName,
			TECH.Title,
			TA.Remarks,
			CASE T.PatientImpact
				WHEN 1 THEN ''YES''
				ELSE ''NO'' 
			END AS PatientImpact,
			T.Comments,
			T.CreatedDate,
			P.ProblemTypeDesc,
			S.SystemDesc,
			TECH1.UPhone,
			TECH1.Extension,
			TECH1.EMailAddress,
			T.DepartmentId,
			D.DCBILLET,
			T.TicketLocation,
			T.StatusId,
			T.OpenDate
		FROM PROBLEM_TYPE P 
		INNER JOIN TICKET T
		INNER JOIN TECHNICIAN TECH
		ON T.CreatedFor = TECH.UserId
		ON P.ProblemTypeId = T.ProblemTypeId 
		INNER JOIN SYSTEM_TYPE S 
		ON T.SystemNameId = S.SystemId 
		INNER JOIN DEPARTMENT D 
		ON T.DepartmentId = D.DepartmentId 
		LEFT OUTER JOIN TICKET_ASSIGNMENT 
		TA INNER JOIN TECHNICIAN TECH1 
		ON TA.AssignedTo = TECH1.UserId 
		ON T.TicketId = TA.TicketId
		WHERE 
			1 = 1 '

IF @tic > 0
	SELECT @sql = @sql + 'AND TicketId = @tic '

IF LEN(@num) > 0
	SELECT @sql = @sql + 'AND TicketNumber = @num '

IF @debug = 1
	PRINT @sql
	PRINT @tic
	PRINT @num

SELECT @paramlist = 	'@tic int,
			@num varchar(50)'
			
EXEC sp_executesql	@sql, @paramlist, @tic, @num
