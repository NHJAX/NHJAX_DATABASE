create FUNCTION [dbo].[MailStatus]()
RETURNS varchar(50) AS  
BEGIN 
	DECLARE @stat	varchar(50);
	IF NOT EXISTS (SELECT * FROM msdb.sys.service_queues WHERE name = N'ExternalMailQueue' AND is_receive_enabled = 1)
       SET @stat =  'STOPPED' 
    ELSE
       SET @stat = 'STARTED' 
	
	RETURN @stat;
END
