

CREATE PROCEDURE [dbo].[upODS_CDM_Additional_Providers_BitBucket] AS

Declare @enc bigint
Declare @pro bigint
Declare @rol bigint
Declare @aprol nvarchar(255)
Declare @appro nvarchar(255)
Declare @apenc float

Declare @encX bigint
Declare @proX bigint
Declare @rolX bigint
Declare @aprolX nvarchar(255)

Declare @trow int
Declare @irow int
Declare @sirow varchar(50)
Declare @strow varchar(50)

Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin CDM BB Provider Role', 0,@day;
DECLARE curRol CURSOR FAST_FORWARD FOR
SELECT DISTINCT RTRIM(LTRIM([Appointment Provider Role]))
FROM [NHJAX-CACHE].STAGING.dbo.BIT_BUCKET_CDM_ADDITIONAL_PROVIDER

OPEN curRol
SET @trow = 0
SET @irow = 0


FETCH NEXT FROM curRol INTO @aprol

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
	
	Select 	@aprolX = ProviderRoleDesc
		FROM NHJAX_ODS.dbo.PROVIDER_ROLE
		WHERE	ProviderRoleDesc = @aprol
		SET		@exists = @@RowCount
		If		@exists = 0 
			
			BEGIN
			
				INSERT INTO NHJAX_ODS.dbo.PROVIDER_ROLE(
				ProviderRoleDesc)
				VALUES(@aprol);
				SET @irow = @irow + 1
			END
	
		SET @trow = @trow + 1
		FETCH NEXT FROM curRol INTO @aprol
		
	COMMIT	
	END
END

CLOSE curRol
DEALLOCATE curRol

SET @sirow = 'CDM BB Provider Role Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'CDM BB Provider Role Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;


--Additional Providers
DECLARE	cur CURSOR FAST_FORWARD FOR 
SELECT DISTINCT 
	PRO.ProviderId, 
	ROL.ProviderRoleId, 
	ENC.PatientEncounterId,
	AP.[Additional Provider],
	AP.[Appointment Provider Role],
	AP.[Appointment Id]
FROM [NHJAX-CACHE].STAGING.dbo.BIT_BUCKET_CDM_ADDITIONAL_PROVIDER AS AP 
	INNER JOIN PROVIDER_ROLE AS ROL 
	ON AP.[Appointment Provider Role] = ROL.ProviderRoleDesc 
	INNER JOIN PATIENT_ENCOUNTER AS ENC 
	ON AP.[Appointment Id] = ENC.CDMAppointmentId 
	INNER JOIN PROVIDER AS PRO 
	ON AP.[Additional Provider] = PRO.ProviderName

OPEN cur
SET @trow = 0
SET @irow = 0

EXEC dbo.upActivityLog 'Fetch CDM BB Additional Providers',0
FETCH NEXT FROM cur INTO @pro,@rol,@enc,@appro,@aprol,@apenc

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@encX = PatientEncounterId
		FROM NHJAX_ODS.dbo.ENCOUNTER_PROVIDER
		WHERE	PatientEncounterId = @enc
			AND ProviderId = @pro
			AND ProviderRoleId = @rol
		SET		@exists = @@RowCount
		If		@exists = 0 
			
			BEGIN
			
				INSERT INTO NHJAX_ODS.dbo.ENCOUNTER_PROVIDER(
				PatientEncounterId,
				ProviderId,
				ProviderRoleId)
				VALUES(@enc,@pro,@rol);
				SET @irow = @irow + 1
				

			END
	
		SET @trow = @trow + 1
		FETCH NEXT FROM cur INTO @pro,@rol,@enc,@appro,@aprol,@apenc
		
	COMMIT	
	END
END

CLOSE cur
DEALLOCATE cur

SET @sirow = 'CDM BB Additional Provider Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'CDM BB Additional Provider Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End CDM BB Additional Provider',0,@day;

--PRINT @sirow
--PRINT @strow

--Process Bit Bucket
EXEC [NHJAX-CACHE].STAGING.dbo.upSTG_BB_CDM_ADDITIONAL_PROVIDER_Delete 
EXEC dbo.upActivityLog 'BB CDM Additional Provider',0;