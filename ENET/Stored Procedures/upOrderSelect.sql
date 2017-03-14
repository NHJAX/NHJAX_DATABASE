CREATE PROCEDURE [dbo].[upOrderSelect](
	
	@onum		varchar(50) = '',
	@oid		int = 0,
	@tech		int = 0,
	@debug	bit = 0
)
 AS

DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)
/*
SELECT @sql = 'SELECT
			AssetOrderId, 
			TKT.TicketNumber, 
			TF.CustomerSatisfied, 
			TF.Comments,
			TF.CreatedDate, 
			TF.CreatedBy,
			TECH.UFName, 
			TECH.ULName, 
			TECH.UMName, 
			ISNULL(FU.StatusId, 0) AS StatusId,
			TKT.TicketId
		FROM         
			TECHNICIAN TECH 
			INNER JOIN TICKET_FEEDBACK TF 
			ON TECH.UserId = TF.CreatedBy 
			LEFT OUTER JOIN TICKET_FEEDBACK_FOLLOW_UP FU 
			ON TF.TicketFeedbackId = FU.TicketFeedbackId 
			LEFT OUTER JOIN TICKET TKT 
			ON TF.TicketId = TKT.TicketId
		WHERE 
			1 = 1 '

IF @all = 0
	SELECT @sql = @sql + 'AND TF.CustomerSatisfied = 0 '

IF LEN(@tik) > 0
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
			@fbk bigint,
			@tech int,
			@tid int '

EXEC sp_executesql	@sql, @paramlist, @all, @tik, @fbk, @tech, @tid
GO
*/
