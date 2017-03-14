CREATE FUNCTION [dbo].[SprintCycle](@date datetime)
RETURNS bigint AS  
BEGIN 
	DECLARE @id	bigint;
	SELECT @id = IsNull(SprintCycleId,0)
	FROM dbo.vwENET_SPRINT_CYCLE
	WHERE @date >= BeginDate
	AND @date < EndDate;

	IF @id = NULL
	BEGIN
		SET @id = 0
	END
	RETURN @id;
END
