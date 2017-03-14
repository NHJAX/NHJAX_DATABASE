CREATE FUNCTION [dbo].[GenerateEncounterKey](@pat bigint)
RETURNS numeric(13,3) AS  
BEGIN 
	Declare @encstring as varchar(25)
	Declare @encnum as numeric(13,3)
	Declare @gen bigint
	Declare @genX varchar(10)

	--UPDATE GENERATOR SET LastNumber=LastNumber+1

	SELECT @gen = LastNumber 
	FROM GENERATOR
	WHERE GeneratorTypeId = 1

	--COMMENT--
	/*@ENCSTRING TAKES THE PATIENT ID, CONVERTS IT TO A STRING, THEN ADDS IT TO A RANDOM NUMBER DIVIDED BY THE RANDOMIZED ENCOUNTER DAY
	 AS A STRING FOR THE ENCOUNTER KEY FIELD.*/
		
	SET @genX 
		= cast(left(cast(@gen as varchar(10)), 
		DataLength(cast(@gen as varchar(10))) - 3) AS varchar(6)) 
		+ '.' 
		+ cast(right(cast(@gen as varchar(10)),3) As varchar(3))

	SET @encstring = cast(cast(@pat as integer) as varchar(15)) + @genX
	SET @encnum = CAST(@encstring AS numeric(13,3))

	return @encnum;
END



