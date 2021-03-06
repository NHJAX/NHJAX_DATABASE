﻿create PROCEDURE [dbo].[upSTG_MAX_PCM]
AS
	
	DECLARE @exists int

	DECLARE @pat numeric(13,3)
	DECLARE @max numeric(17,3)
	DECLARE @pcm numeric(17,3)

EXEC dbo.upActivityLog 'Begin STG Max PCM',0;

TRUNCATE TABLE STG_MAX_PCM;

--DECLARE curSTGMaxEnr CURSOR FAST_FORWARD FOR
INSERT INTO STG_MAX_PCM
(
	KEY_NED_PATIENT,
	MaxEnr,
	MaxPcm
)
SELECT     
	HIST.KEY_NED_PATIENT, 
	ENR.MaxEnr,
	MAX(HIST.PCM_HISTORY_NUMBER) AS MaxPcm
FROM
	dbo.NED_PATIENT$ENROLLMENT_HISTORY$PCM_HISTORY AS HIST 
	INNER JOIN dbo.STG_MAX_ENROLLMENT AS ENR 
	ON HIST.KEY_NED_PATIENT = ENR.KEY_NED_PATIENT 
	AND HIST.KEY_NED_PATIENT$ENROLLMENT_HISTORY = ENR.MaxEnr
GROUP BY HIST.KEY_NED_PATIENT, ENR.MaxEnr

--OPEN curSTGPat

EXEC dbo.upActivityLog 'End STG Max PCM',0

/*FETCH NEXT FROM curSTGPat INTO @pat

if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		BEGIN TRANSACTION

			INSERT INTO STG_PATIENT_ACTIVITY
			(
			Patient_Ien
			)
			VALUES
			(@pat);
	
		FETCH NEXT FROM curSTGPat INTO @pat

		COMMIT
	END

END
CLOSE curSTGPat
DEALLOCATE curSTGPat


EXEC dbo.upActivityLog 'End STG Patient Activity',0;

*/
