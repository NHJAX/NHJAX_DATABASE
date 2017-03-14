


CREATE FUNCTION [dbo].[SpecificDrugs]
	(
	@dm bigint
	)
RETURNS varchar(8000) 	
AS
BEGIN
	SET QUOTED_IDENTIFIER OFF
	DECLARE @str varchar(5000)
	DECLARE @dsd varchar(100)
	DECLARE @ctr bigint

	DECLARE curDSD CURSOR FAST_FORWARD FOR

	SELECT     
		DSD.DiseaseSpecificDrugDesc
	FROM
		DRUG_CATEGORY DC 
		INNER JOIN DISEASE_SPECIFIC_DRUG DSD 
		ON DC.DiseaseSpecificDrugId = DSD.DiseaseSpecificDrugId
	WHERE     (DC.DiseaseManagementId = @dm)

	OPEN curDSD

	FETCH NEXT FROM curDSD INTO @dsd
	if(@@FETCH_STATUS = 0)
	BEGIN
		SET @ctr = 1
		WHILE(@@FETCH_STATUS = 0)
		BEGIN
			IF @ctr = 1
			BEGIN
				SET @str = 'DRUG.DrugDesc LIKE ' + "'" + '%' + @dsd + '%' + "'" 
			END
			ELSE
			BEGIN
				SET @str = @str + ' OR DRUG.DrugDesc LIKE ' + "'" + '%' + @dsd + '%' + "'" 
			END
			SET @ctr = @ctr + 1

			FETCH NEXT FROM curDSD INTO @dsd
		END
	END
	CLOSE curDSD
	DEALLOCATE curDSD
	RETURN @str
END



