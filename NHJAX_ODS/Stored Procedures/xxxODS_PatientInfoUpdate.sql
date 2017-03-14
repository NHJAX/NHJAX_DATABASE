create PROCEDURE [dbo].[xxxODS_PatientInfoUpdate] AS

Declare @fname varchar(50)
Declare @mname varchar(50)
Declare @lname varchar(50)
Declare @key varchar(50)
Declare @id bigint


DECLARE cur CURSOR FAST_FORWARD FOR
SELECT DISTINCT 
	XPAT.PatientId,
	XPAT.PatientKey, 
	XPAT.LastName, 
	XPAT.FirstName, 
	XPAT.MiddleName

FROM vwxxx_PATIENT20090522 AS XPAT
INNER JOIN PATIENT AS PAT
ON XPAT.PatientId = PAT.PatientId
WHERE     (PAT.SourceSystemId = 12)
ORDER BY XPAT.LastName
OPEN cur

FETCH NEXT FROM cur INTO @id,@key,@lname,@fname,@mname
if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN	
	BEGIN TRANSACTION
		UPDATE PATIENT
			SET SourceSystemKey = @key,
					ODSFName = @fname,
					ODSMName = @mname,
					ODSLName = @lname
		
			WHERE PatientId = @id;
		FETCH NEXT FROM cur INTO @id,@key,@lname,@fname,@mname
	COMMIT
	END
END
CLOSE cur
DEALLOCATE cur