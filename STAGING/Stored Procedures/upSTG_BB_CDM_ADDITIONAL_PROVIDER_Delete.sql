CREATE Procedure [dbo].[upSTG_BB_CDM_ADDITIONAL_PROVIDER_Delete]

AS

DECLARE @appro varchar(255)
DECLARE @aprol varchar(255)
DECLARE @apenc float

DECLARE	cur CURSOR FAST_FORWARD FOR

SELECT DISTINCT 
	AP.[Additional Provider],
	AP.[Appointment Provider Role],
	AP.[Appointment Id]
FROM BIT_BUCKET_CDM_ADDITIONAL_PROVIDER AS AP 
	INNER JOIN [NHJAX-ODS].NHJAX_ODS.dbo.PROVIDER_ROLE AS ROL 
	ON AP.[Appointment Provider Role] = ROL.ProviderRoleDesc 
	INNER JOIN [NHJAX-ODS].NHJAX_ODS.dbo.PATIENT_ENCOUNTER AS ENC 
	ON AP.[Appointment Id] = ENC.CDMAppointmentId 
	INNER JOIN [NHJAX-ODS].NHJAX_ODS.dbo.PROVIDER AS PRO 
	ON AP.[Additional Provider] = PRO.ProviderName
	
OPEN cur

FETCH NEXT FROM cur INTO @appro,@aprol,@apenc

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
	
	DELETE FROM BIT_BUCKET_CDM_ADDITIONAL_PROVIDER
	WHERE [Additional Provider] = @appro
		AND [Appointment Provider Role] = @aprol
		AND [Appointment Id] = @apenc
		
	FETCH NEXT FROM cur INTO @appro,@aprol,@apenc
		
	COMMIT	
	END
END

CLOSE cur
DEALLOCATE cur
