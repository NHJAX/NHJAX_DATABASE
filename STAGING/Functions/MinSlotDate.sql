﻿CREATE FUNCTION [dbo].[MinSlotDate]()
RETURNS datetime AS  
BEGIN 
	DECLARE @minDate	datetime;
	SELECT @minDate = MIN(DATE_TIME) 
		FROM CDSS2.dbo.SCHEDULABLE_ENTITY$SCHEDULE_DATE_TIMES TIMES
	RETURN @minDate;
END
