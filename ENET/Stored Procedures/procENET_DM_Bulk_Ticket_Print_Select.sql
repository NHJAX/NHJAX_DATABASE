CREATE PROCEDURE [dbo].[procENET_DM_Bulk_Ticket_Print_Select]
(
	@sess varchar(50) = 'xyz',
	@srt varchar(50) = 'Priority',
	@ord int = 0
)
 AS

DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)

SELECT @sql = 'SELECT     
	SessionKey, 
	TicketNumber, 
	TicketId, 
	TicketLocation, 
	SystemDesc, 
	ProblemTypeDesc, 
	PatientImpact, 
	UserAlpha, 
	CreatedDate, 
	AudienceDesc, 
	OrgChartCode, 
	UserPhone, 
	UserExtension, 
	AsgPhone, 
	AsgExtension, 
	ClsPhone, 
	ClsExtension, 
	PlantAccountNumber, 
	AssignedTo, 
	UserTitle, 
	UserEMail,
	UserAudienceDesc, 
	UserOrgChartCode, 
	UserLocation, 
	CreatedFor, 
	AsgClosedDate, 
	AssignedDate, 
	Comments, 
	AsgAlpha, 
	AsgEMail, 
	ClsAlpha, 
	ClsEMail, 
	DMCreatedDate, 
	StatusId, 
	Remarks, 
	OpenDate, 
	DisplayName, 
	UserDisplayName,
	PriorityId,
	SoftwareDesc
FROM DM_BULK_TICKET_PRINT
WHERE (SessionKey = @sess) '

IF @srt = 'SystemDesc'
	BEGIN
	SELECT @sql = @sql + 'ORDER BY SystemDesc '
	END
IF @srt = 'Priority'
	BEGIN
	SELECT @sql = @sql + 'ORDER BY PriorityId '
	END
IF @srt = 'DaysOpen'
	BEGIN
	SELECT @sql = @sql + 'ORDER BY OpenDate '
	END
IF @srt = 'OpenDate'
	BEGIN
	SELECT @sql = @sql + 'ORDER BY OpenDate '
	END
IF @srt = 'ProblemTypeDesc'
	BEGIN
	SELECT @sql = @sql + 'ORDER BY ProblemTypeDesc '
	END
IF @srt = 'SoftwareDesc'
	BEGIN
	SELECT @sql = @sql + 'ORDER BY SoftwareDesc '
	END
IF @srt = 'TicketAudienceDisplay'
	BEGIN
	SELECT @sql = @sql + 'ORDER BY AudienceDesc '
	END
IF @srt = 'x'
	BEGIN
	SELECT @sql = @sql + 'ORDER BY TicketNumber '
	END


IF @ord = 1
	BEGIN
		SELECT @sql = @sql + 'DESC, TicketId'
	END
ELSE
	BEGIN
		SELECT @sql = @sql + 'ASC, TicketId'
	END

PRINT @srt
PRINT @ord
PRINT @sess
PRINT @sql
	
SELECT @paramlist = '@sess varchar(50)'
			
EXEC sp_executesql	@sql, @paramlist, @sess


