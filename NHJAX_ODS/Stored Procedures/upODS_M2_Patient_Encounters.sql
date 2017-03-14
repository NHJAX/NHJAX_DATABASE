



CREATE PROCEDURE [dbo].[upODS_M2_Patient_Encounters] AS

Declare @pe numeric(14,3)
Declare @pat bigint
Declare @svc datetime
Declare @loc bigint
Declare @pro bigint
Declare @stat bigint
Declare @atyp bigint
Declare @mep bigint
Declare @src bigint

Declare @peX numeric(14,3)
Declare @patX bigint
Declare @svcX datetime
Declare @locX bigint
Declare @proX bigint
Declare @statX bigint
Declare @atypX bigint
Declare @mepX bigint
Declare @srcX bigint

Declare @trow int
Declare @irow int
Declare @urow int
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @surow varchar(50)
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

--Declare @encstring as varchar(25)
--Declare @encnum as numeric(13,3)

EXEC dbo.upActivityLog 'Begin M2 Patient Encounter',0,@day;


DECLARE	curM2Enc CURSOR FAST_FORWARD FOR 
SELECT	
	PROD.[Record ID], 
	ENC.PatientId, 
	PROD.[Service Date], 
	ENC.HospitalLocationId, 
	ISNULL(PROCD.ProviderId, 0) AS ProviderId, 
	STAT.AppointmentStatusId, 
	ISNULL(ATYP.AppointmentTypeId, 0) AS AppointmentTypeId,
	ISNULL(ENC.MeprsCodeId,0) AS MeprsCodeId,
	7 AS SourceSystemId	
FROM	PATIENT_ENCOUNTER AS ENC 
	INNER JOIN vwSTG_PRODUCTIVITY AS PROD 
	ON ENC.PatientAppointmentKey = PROD.[Record ID] 
	AND ENC.SourceSystemId < 7 
	INNER JOIN APPOINTMENT_STATUS AS STAT 
	ON PROD.[Appt Status Cd] = STAT.AppointmentStatusKey 
	LEFT OUTER JOIN APPOINTMENT_TYPE AS ATYP 
	ON PROD.[Appointment Type] = ATYP.AppointmentTypeCode 
	LEFT OUTER JOIN PROVIDER_CODE AS PROCD 
	ON PROD.[Provider ID] = PROCD.ProviderCode

OPEN curM2Enc
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch M2 Patient Encounter',0
FETCH NEXT FROM curM2Enc INTO @pe,@pat,@svc,@loc,@pro,@stat,@atyp,@mep,@src

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@peX = PatientEncounterId,
			@patX = PatientId,
			@svcX = AppointmentDateTime,
			@locX = HospitalLocationId,
			@proX = ProviderId,
			@statX = AppointmentStatusId,
			@atypX = AppointmentTypeId,
			@mepX = MeprsCodeId
		FROM NHJAX_ODS.dbo.PATIENT_ENCOUNTER
		WHERE PatientAppointmentKey = @pe
		AND SourceSystemId = 7
		
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN

				--PRINT @appt
				--PRINT @pat
				--PRINT @enc

				INSERT INTO NHJAX_ODS.dbo.PATIENT_ENCOUNTER(
				PatientAppointmentKey,
				PatientId,
				AppointmentDateTime,
				HospitalLocationId,
				ProviderId,
				AppointmentStatusId,
				AppointmentTypeId,
				MeprsCodeId,
				SourceSystemId)
				VALUES(@pe,@pat,@svc,@loc,@pro,@stat,@atyp,@mep,@src);
				SET @irow = @irow + 1	

			END
		ELSE
			BEGIN

		IF	@pat <> @patX
		OR	@svc <> @svcX
		OR	@loc <> @locX
		OR	@pro <> @proX
		OR	@stat <> @statX
		OR	@atyp <> @atypX	
		OR	@mep <> @mepX
		OR 	(@pat Is Not Null AND @patX Is Null)
		OR 	(@svc Is Not Null AND @svcX Is Null)
		OR 	(@loc Is Not Null AND @locX Is Null)
		OR 	(@pro Is Not Null AND @proX Is Null)
		OR 	(@stat Is Not Null AND @statX Is Null)
		OR	(@atyp Is Not Null AND @atypX Is Null)
		OR	(@mep Is Not Null AND @mepX Is Null)
			BEGIN
			--SET @today = getdate()
			UPDATE NHJAX_ODS.dbo.PATIENT_ENCOUNTER
			SET 	PatientId = @pat,
				AppointmentDateTime = @svc,
				HospitalLocationId = @loc,
				ProviderId = @pro,
				AppointmentStatusId = @stat,
				AppointmentTypeId = @atyp,
				MeprsCodeId = @mep,
				UpdatedDate = getdate()
			WHERE PatientAppointmentKey = @pe
			AND SourceSystemId = 7;
			SET @urow = @urow + 1
			END
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM curM2Enc INTO @pe,@pat,@svc,@loc,@pro,@stat,@atyp,@mep,@src
		
	COMMIT	
	END
END

CLOSE curM2Enc
DEALLOCATE curM2Enc

SET @sirow = 'M2 Patient Encounter Inserted: ' + CAST(@irow AS varchar(50))
SET @surow = 'M2 Patient Encounter Updated: ' + CAST(@urow AS varchar(50))
SET @strow = 'M2 Patient Encounter Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End M2 Patient Encounter',0,@day;
