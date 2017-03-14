
CREATE PROCEDURE [dbo].[upODS_xxx20091030] AS
Declare @pat bigint
Declare @cod varchar(255)
Declare @fn varchar(255)
Declare @ln varchar(255)

Declare @exists int

DECLARE cur CURSOR FAST_FORWARD FOR
SELECT DISTINCT 
	PAT.PatientId, 
	FMP.FamilyMemberPrefixCode + '/' + RIGHT(PAT.SponsorSSN, 4) AS FMPSPON, 
	PAT.ODSFName, 
	PAT.ODSLName
FROM PATIENT AS PAT 
INNER JOIN FAMILY_MEMBER_PREFIX AS FMP 
ON PAT.FamilyMemberPrefixId = FMP.FamilyMemberPrefixId 
INNER JOIN [200910MASTER] 
ON [200910MASTER].FMPSSN = FMP.FamilyMemberPrefixCode 
	+ '/' + RIGHT(PAT.SponsorSSN, 4) 
AND PAT.ODSLName = [200910MASTER].LName 
AND PAT.ODSFName = [200910MASTER].FName
WHERE     (PAT.Sex = 'Female')
		
OPEN cur

FETCH NEXT FROM cur INTO @pat,@cod,@fn,@ln

if(@@FETCH_STATUS = 0)

BEGIN
BEGIN TRANSACTION
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
			UPDATE [200910MASTER]
			SET 	PatientIdentifier = @pat
			WHERE  FMPSSN = @cod
			AND LName = @ln
			AND FName = @fn;
	
		FETCH NEXT FROM cur INTO @pat,@cod,@fn,@ln
	END
COMMIT

END


CLOSE cur
DEALLOCATE cur

