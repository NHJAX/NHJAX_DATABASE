create FUNCTION [dbo].[GenerateOrderKey](@pat bigint)
RETURNS numeric(14,3) AS  
BEGIN 
	Declare @ordstring as varchar(25)
	Declare @ordnum as numeric(14,3)
	Declare @gen bigint
	Declare @genX varchar(10)

	--UPDATE GENERATOR SET LastNumber=LastNumber+1

	SELECT @gen = LastNumber 
	FROM GENERATOR
	WHERE GeneratorTypeId = 2

	--COMMENT--
	/*@ORDSTRING TAKES THE PATIENT ID, CONVERTS IT TO A STRING, THEN ADDS IT TO A RANDOM NUMBER DIVIDED BY THE RANDOMIZED ENCOUNTER DAY
	 AS A STRING FOR THE ENCOUNTER KEY FIELD.*/
		
	SET @genX 
		= cast(left(cast(@gen as varchar(10)), 
		DataLength(cast(@gen as varchar(10))) - 3) AS varchar(6)) 
		+ '.' 
		+ cast(right(cast(@gen as varchar(10)),3) As varchar(3))

	SET @ordstring = cast(cast(@pat as integer) as varchar(15)) + @genX
	SET @ordnum = CAST(@ordstring AS numeric(13,3))

	return @ordnum;
END



