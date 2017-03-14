

CREATE PROCEDURE [dbo].[upODS_PatientName]
AS
BEGIN

Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Patient Name',0,@day;

UPDATE PATIENT
SET ODSFName = NedFName,
	ODSMName = NedMName,
	ODSLName = NedLName
WHERE NedLName Is Not NULL
AND PatientId IN 
	(
	SELECT PatientId 
	FROM PATIENT_ACTIVITY
	)

Declare @id bigint
Declare @lname varchar(50)
Declare @fname varchar(50)
Declare @mname varchar(50)

DECLARE cur CURSOR FAST_FORWARD FOR
SELECT  PatientId,   
LEFT(FullName, CHARINDEX(',', FullName) - 1) AS LastName, 
CASE CHARINDEX(' ', FullName)
WHEN 0 THEN RIGHT(FullName, LEN(FullName) - CHARINDEX(',', FullName))
ELSE
LEFT(RIGHT(FullName, LEN(FullName) - CHARINDEX(',', FullName)),CHARINDEX(' ', RIGHT(FullName, LEN(FullName) - CHARINDEX(',', FullName) - 1))) END
 AS FirstName,
CASE CHARINDEX(' ', FullName)
WHEN 0 THEN ''
ELSE RIGHT(FullName, LEN(FullName) - CHARINDEX(' ', FullName)) 
END AS MiddleName
FROM         PATIENT
WHERE     (NedLName IS NULL) AND (CHARINDEX(',', FullName) > 0)
AND ODSLName IS NULL

OPEN cur

EXEC dbo.upActivityLog 'Fetch Patient Name',0

FETCH NEXT FROM cur INTO @id,@lname,@fname,@mname

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		BEGIN
		UPDATE PATIENT
		SET ODSLName = @lname,
			ODSFName = @fname,
			ODSMName = @mname
		WHERE PatientId = @id
		END
	
		FETCH NEXT FROM cur INTO @id,@lname,@fname,@mname
	
	COMMIT
	END
END

CLOSE cur
DEALLOCATE cur

EXEC dbo.upActivityLog 'End Patient Name',0,@day;

END

