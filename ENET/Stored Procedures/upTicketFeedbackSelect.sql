CREATE PROCEDURE [dbo].[upTicketFeedbackSelect](
	@all 		bit = 0,
	@tik		varchar(50) = '',
	@fbk		int = 0,
	@tech		int = 0,
	@tid		int = 0,
	@debug	bit = 0
)
 AS

DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)

SELECT @sql = 'SELECT     
	TF.TicketFeedbackId, 
	TKT.TicketNumber, 
	TF.CustomerSatisfied, 
	TF.Comments, 
	TF.CreatedDate, 
	TF.CreatedBy, 
	TECH.UFName, 
	TECH.ULName, 
	TECH.UMName, 
	ISNULL(FU.StatusId, 0) AS StatusId, 
	TKT.TicketId, 
	ISNULL(FU.AssignedTo, 0) AS AssignedTo, 
	ASG.UFName AS AsgFName, 
	ASG.ULName AS AsgLName, 
	ASG.UMName AS AsgUName
FROM	TECHNICIAN ASG 
	INNER JOIN TICKET_FEEDBACK_FOLLOW_UP FU 
	ON ASG.UserId = FU.AssignedTo 
	RIGHT OUTER JOIN TECHNICIAN TECH 
	INNER JOIN TICKET_FEEDBACK TF 
	ON TECH.UserId = TF.CreatedBy 
	ON FU.TicketFeedbackId = TF.TicketFeedbackId 
	LEFT OUTER JOIN TICKET TKT 
	ON TF.TicketId = TKT.TicketId
WHERE 1 = 1 '

IF @all = 0
	SELECT @sql = @sql + 'AND TF.CustomerSatisfied = 0 '

IF DataLength(@tik) > 0
	SELECT @sql = @sql + 'AND TKT.TicketNumber = @tik '

IF @fbk > 0
	SELECT @sql = @sql + 'AND TF.TicketFeedbackId = @fbk '

IF @tech > 0
	SELECT @sql = @sql + 'AND FU.AssignedTo = @tech '

IF @tid > 0
	SELECT @sql = @sql + 'AND TKT.TicketId = @tid '

SELECT @sql = @sql + 'ORDER BY TF.CustomerSatisfied, TF.CreatedDate DESC, FU.StatusId '

IF @debug = 1
	PRINT @sql
	PRINT @tik

SELECT @paramlist = 	'@xall bit,
			@tik varchar(50),
			@fbk int,
			@tech int,
			@tid int '

EXEC sp_executesql	@sql, @paramlist, @all, @tik, @fbk, @tech, @tid
