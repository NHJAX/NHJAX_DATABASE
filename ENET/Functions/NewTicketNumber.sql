﻿CREATE FUNCTION [dbo].[NewTicketNumber](@todayString varchar(4))
RETURNS nvarchar(50) AS  
BEGIN 
	
	DECLARE @ticketNo nvarchar(50)
	DECLARE @number int
	DECLARE @numberString varchar(5)

	SELECT TOP 1 @ticketNo =  TicketNumber FROM TICKET 
	WHERE TicketNumber LIKE @todayString + '%'
	ORDER BY TicketNumber DESC

	IF @ticketNo = '' OR @ticketNo IS NULL
		SET @ticketNo = '00000'

	SET @number = CAST(RIGHT(@ticketNo, 5) AS int)

	SET @number = @number + 1

	SET @numberString = RIGHT('00000' + CAST(@number AS varchar(5)), 5)

	return @todayString + 'JAX' + @numberString;
END
