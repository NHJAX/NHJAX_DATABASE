

create PROCEDURE [dbo].[upODS_PatientEncounter_DMIS_20090325] AS

Declare @id bigint
Declare @loc bigint
Declare @mep bigint
Declare @dmis bigint
Declare @ss int
Declare @enc numeric(13,3)

Declare @idX bigint
Declare @locX bigint
Declare @ssX bigint
Declare @mepX bigint
Declare @dmisX bigint
Declare @encX numeric(13,3)

Declare @urow int
Declare @trow int

Declare @surow varchar(50)
Declare @strow varchar(50)

Declare @exists int

EXEC dbo.upActivityLog 'Begin Encounter DMIS',0;

DECLARE cur CURSOR FAST_FORWARD FOR
Select	PatientEncounterId, 
		ISNULL(HospitalLocationId,0), 
		ISNULL(MeprsCodeId,0), 
		ISNULL(SourceSystemId,0),
		EncounterKey
FROM PATIENT_ENCOUNTER
WHERE DMISId IS NULL
AND SourceSystemId <> 6

OPEN cur
SET @trow = 0
SET @urow = 0

EXEC dbo.upActivityLog 'Fetch Encounter DMIS',0
FETCH NEXT FROM cur INTO @id,@loc,@mep,@ss,@enc
if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
	
	--Multi-level checking for updates
	IF @loc > 0
		BEGIN
			--Lookup Meprs if needed and dmis
			SELECT     
				@locX = LOC.HospitalLocationId, 
				@mepX = LOC.MeprsCodeId, 
				@dmisX = MEP.DmisId
			FROM HOSPITAL_LOCATION AS LOC 
				INNER JOIN MEPRS_CODE AS MEP 
				ON LOC.MeprsCodeId = MEP.MeprsCodeId
			WHERE HospitalLocationId = @loc
				
			If @mep = 0 OR (@mepX > 0 AND @mep IS NULL)
				BEGIN
					UPDATE PATIENT_ENCOUNTER
					SET MeprsCodeId = @mepX
					WHERE PatientEncounterId = @id
				END
				
			UPDATE PATIENT_ENCOUNTER
			SET DMISId = @dmisX
			WHERE PatientEncounterId = @id
			
			SET @urow = @urow + 1
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM cur INTO @id,@loc,@mep,@ss,@enc
	COMMIT
	END

END
CLOSE cur
DEALLOCATE cur
SET @surow = 'Encounter DMIS Updated: ' + CAST(@urow AS varchar(50))
SET @strow = 'Encounter DMIS Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Encounter DMIS',0;





