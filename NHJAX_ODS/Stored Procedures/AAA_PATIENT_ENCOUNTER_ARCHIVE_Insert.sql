
CREATE PROCEDURE [dbo].[AAA_PATIENT_ENCOUNTER_ARCHIVE_Insert]

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON;

Declare @loop int
Declare @exists int

Declare @encID bigint
Declare @appt decimal
Declare @enc decimal
Declare @pat bigint
Declare @date datetime
Declare @loc bigint
Declare @pro bigint
Declare @duration decimal
Declare @stat bigint
Declare @reason varchar(80)
Declare @disp bigint
Declare @type bigint
Declare @ref bigint
Declare @adm datetime
Declare @dis datetime
Declare @cdate datetime
Declare @udate datetime
Declare @made datetime
Declare @atc bigint
Declare	@datc datetime
Declare @pri bigint
Declare @ss bigint
Declare @ac bigint
Declare @seen int
Declare @rel bigint
Declare @drel datetime
Declare @mep bigint
Declare @non bit
Declare @cdm float
Declare @dmis bigint
Declare @ssk varchar(50)
Declare @er varchar(30)
--Declare @num varchar(50)
--Declare @locX decimal
Declare @encIDX bigint

Declare @msg varchar(50)
Declare @msged varchar(50)
DECLARE @hisdate datetime

SET @hisdate = DATEADD(YEAR,-10,GETDATE())

EXEC NHJAX_ODS_ARCHIVE.dbo.upActivityLog 'Begin Patient_Encounter_Archive',0,0;

DECLARE curArch CURSOR FAST_FORWARD FOR
SELECT --TOP 1
	PatientEncounterId, 
	PatientAppointmentKey, 
	EncounterKey, 
	PatientId, 
	AppointmentDateTime, 
	HospitalLocationId, 
	ProviderId, 
	Duration, 
    AppointmentStatusId, 
    ReasonForAppointment, 
    PatientDispositionId, 
    AppointmentTypeId, 
    ReferralId, 
    AdmissionDateTime, 
    DischargeDateTime, 
    CreatedDate, 
    UpdatedDate, 
    DateAppointmentMade, 
    AccessToCareId, 
    AccessToCareDate, 
    PriorityId, 
    SourceSystemId, 
    ArrivalCategoryId, 
    ReasonSeenId, 
    ReleaseConditionId, 
    ReleaseDateTime, 
    MeprsCodeId, 
    IsNonCount, 
    CDMAppointmentId, 
    DMISId, 
    SourceSystemKey, 
    EREntryNumber
FROM PATIENT_ENCOUNTER
WHERE (AppointmentDateTime < @hisdate
AND PatientId NOT IN (SELECT PatientId FROM PATIENT_ACTIVITY))
OR (PatientId IN (SELECT PatientId FROM PATIENT WHERE PatientDeceased = 1)
AND AppointmentDateTime < @hisdate)
	 
OPEN curArch

FETCH NEXT FROM curArch INTO @encID,@appt,@enc,@pat,@date,@loc,
	@pro,@duration,@stat,@reason,@disp,@type,@ref,@adm,@dis,@cdate,
	@udate,@made,@atc,@datc,@pri,@ss,@ac,@seen,@rel,@drel,@mep,@non,
	@cdm,@dmis,@ssk,@er

if(@@FETCH_STATUS = 0)
BEGIN

	--PRINT @encID
	SET @msg = 'EncId:' + CAST(@encId AS varchar(50))
	EXEC NHJAX_ODS_ARCHIVE.dbo.upActivityLog @msg,0,0;
	
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
			SELECT @encIDX = PatientEncounterId
			FROM NHJAX_ODS_ARCHIVE.dbo.PATIENT_ENCOUNTER_ARCHIVE
			WHERE PatientEncounterId = @encID
			SET @exists = @@RowCount
			IF @exists = 0
			BEGIN
			
			INSERT INTO NHJAX_ODS_ARCHIVE.dbo.PATIENT_ENCOUNTER_ARCHIVE
			(
				PatientEncounterId, 
				PatientAppointmentKey, 
				EncounterKey, 
				PatientId, 
				AppointmentDateTime, 
				HospitalLocationId, 
				ProviderId, 
				Duration, 
				AppointmentStatusId, 
				ReasonForAppointment, 
				PatientDispositionId, 
				AppointmentTypeId, 
				ReferralId, 
				AdmissionDateTime, 
				DischargeDateTime, 
				CreatedDate, 
				UpdatedDate, 
				DateAppointmentMade, 
				AccessToCareId, 
				AccessToCareDate, 
				PriorityId, 
				SourceSystemId, 
				ArrivalCategoryId, 
				ReasonSeenId, 
				ReleaseConditionId, 
				ReleaseDateTime, 
				MeprsCodeId, 
				IsNonCount, 
				CDMAppointmentId, 
				DMISId, 
				SourceSystemKey, 
				EREntryNumber
			)
			VALUES
			(
				@encID,
				@appt,
				@enc,
				@pat,
				@date,
				@loc,
				@pro,
				@duration,
				@stat,
				@reason,
				@disp,
				@type,
				@ref,
				@adm,
				@dis,
				@cdate,
				@udate,
				@made,
				@atc,
				@datc,
				@pri,
				@ss,
				@ac,
				@seen,
				@rel,
				@drel,
				@mep,
				@non,
				@cdm,
				@dmis,
				@ssk,
				@er
			)
			
			--PRINT 'Insert'
			END
			
			--Check for Child Tables
			BEGIN--AHLTA_IMMUNIZATION
			
				Declare @ai bigint
				Declare @aiX bigint
				Declare @vname varchar(255)
				Declare @idate datetime
				Declare @ndate datetime
				Declare @ser float
				Declare @exm varchar(50)
				Declare @exmdate datetime
				Declare @dos varchar(50)
				Declare @lot varchar(50)
				Declare @cd bigint
				Declare @ityp int
				Declare @man bigint
				Declare @aicdate datetime
				
				DECLARE curAI CURSOR FAST_FORWARD FOR
				SELECT     
					AhltaImmunizationId, 
					ImmunizationVaccineName, 
					ImmunizationDate, 
					ImmunizationDateNextDue, 
					ImmunizationSeries, 
					ImmunizationExemption, 
					ImmunizationExemptionExpireDate, 
					ImmunizationDosage, 
					ImmunizationLotNumber, 
					ImmunizationCodeId, 
					ImmunizationTypeId, 
					ImmunizationManufacturerId, 
					CreatedDate
				FROM AHLTA_IMMUNIZATION
				WHERE PatientEncounterId = @encID
				
				OPEN curAI

				FETCH NEXT FROM curAI INTO @ai,@vname,@idate,@ndate,
				@ser,@exm,@exmdate,@dos,@lot,@cd,@ityp,@man,@aicdate

				if(@@FETCH_STATUS = 0)
				BEGIN
					
					WHILE(@@FETCH_STATUS = 0)
					BEGIN
						SELECT @aiX = AhltaImmunizationId
						FROM NHJAX_ODS_ARCHIVE.dbo.AHLTA_IMMUNIZATION_ARCHIVE
						WHERE AhltaImmunizationId = @ai
						SET @exists = @@RowCount
						IF @exists = 0
						BEGIN
						INSERT INTO NHJAX_ODS_ARCHIVE.dbo.AHLTA_IMMUNIZATION_ARCHIVE
						(
							AhltaImmunizationId,  
							ImmunizationVaccineName, 
							ImmunizationDate, 
							ImmunizationDateNextDue, 
							ImmunizationSeries, 
							ImmunizationExemption, 
							ImmunizationExemptionExpireDate, 
							ImmunizationDosage, 
							ImmunizationLotNumber, 
							ImmunizationCodeId, 
							ImmunizationTypeId, 
							ImmunizationManufacturerId, 
							CreatedDate,
							PatientEncounterId
						)
						VALUES
						(
							@ai,
							@vname,
							@idate,
							@ndate,
							@ser,
							@exm,
							@exmdate,
							@dos,
							@lot,
							@cd,
							@ityp,
							@man,
							@aicdate,
							@encID
						)
						END --End AI Insert	
										
					FETCH NEXT FROM curAI INTO @ai,@vname,@idate,
						@ndate,@ser,@exm,@exmdate,@dos,@lot,@cd,
						@ityp,@man,@aicdate
					
					END --End While
				END
				CLOSE curAI
				DEALLOCATE curAI
				
				--Delete AHLTA_IMMUNIZATION
				DELETE FROM AHLTA_IMMUNIZATION
				WHERE AhltaImmunizationId = @ai
				--PRINT 'Delete AI'
				END --ALTHA_IMMUNIZATION
				
				BEGIN--APPOINTMENT_AUDIT_TRAIL
			
				Declare @aat bigint
				Declare @aatX bigint
				Declare @aatk numeric(14,3)
				Declare @astat bigint
				Declare @hloc bigint
				Declare @mcd bigint
				Declare @chcs bigint
				Declare @aatcdate datetime
				Declare @mod bigint
								
				DECLARE curAAT CURSOR FAST_FORWARD FOR
				SELECT     
					AppointmentAuditTrailId, 
					AppointmentAuditTrailKey, 
					AppointmentStatusId, 
					HospitalLocationId, 
					MedicalCenterDivisionId,  
					CHCSUserId, 
					CreatedDate, 
					StatusModifierId
				FROM APPOINTMENT_AUDIT_TRAIL
				WHERE PatientEncounterId = @encID
				
				OPEN curAAT

				FETCH NEXT FROM curAAT INTO @aat,@aatk,@astat,@hloc,
					@mcd,@chcs,@aatcdate,@mod

				if(@@FETCH_STATUS = 0)
				BEGIN
					
					WHILE(@@FETCH_STATUS = 0)
					BEGIN
						SELECT @aatX = AppointmentAuditTrailId
						FROM NHJAX_ODS_ARCHIVE.dbo.APPOINTMENT_AUDIT_TRAIL_ARCHIVE
						WHERE AppointmentAuditTrailId = @aat
						SET @exists = @@RowCount
						IF @exists = 0
						BEGIN
						INSERT INTO NHJAX_ODS_ARCHIVE.dbo.APPOINTMENT_AUDIT_TRAIL_ARCHIVE
						(
							AppointmentAuditTrailId, 
							AppointmentAuditTrailKey, 
							AppointmentStatusId, 
							HospitalLocationId, 
							MedicalCenterDivisionId,  
							CHCSUserId, 
							CreatedDate, 
							StatusModifierId,
							PatientEncounterId
						)
						VALUES
						(
							@aat,
							@aatk,
							@astat,
							@hloc,
							@mcd,
							@chcs,
							@aatcdate,
							@mod,
							@encID
						)
						END --End AAT Insert	
										
					FETCH NEXT FROM curAAT INTO @aat,@aatk,
					@astat,@hloc,
					@mcd,@chcs,@aatcdate,@mod
					
					END --End While
				END
				CLOSE curAAT
				DEALLOCATE curAAT
				
				--Delete APPOINTMENT_AUDIT_TRAIL
				DELETE FROM APPOINTMENT_AUDIT_TRAIL
				WHERE AppointmentAuditTrailId = @aat
				--PRINT 'Delete AAT'
				END --APPOINTMENT_AUDIT_TRAIL
				
				BEGIN--ENCOUNTER_DIAGNOSIS
				--EXEC NHJAX_ODS_ARCHIVE.dbo.upActivityLog 'BEGIN ED',0,0;
				
				Declare @ed bigint
				Declare @edX bigint
				Declare @diag bigint
				Declare @edpri int
				Declare @desc varchar(500)
				Declare @edcdate datetime
				Declare @edcudate datetime
				Declare @edss bigint
								
				DECLARE curED CURSOR FAST_FORWARD FOR
				SELECT     
					EncounterDiagnosisId,  
					DiagnosisId, 
					Priority, 
					[Description], 
					CreatedDate, 
					UpdatedDate, 
					SourceSystemId
				FROM ENCOUNTER_DIAGNOSIS
				WHERE PatientEncounterId = @encID
				
				OPEN curED

				FETCH NEXT FROM curED INTO @ed,@diag,@edpri,
					@desc,@edcdate,@edcudate,@edss
					
				SET @msged = CAST(@ed as varchar(50))
				--EXEC NHJAX_ODS_ARCHIVE.dbo.upActivityLog @msged,0,0;
				if(@@FETCH_STATUS = 0)
				BEGIN
					
					WHILE(@@FETCH_STATUS = 0)
					BEGIN
						SELECT @edX = EncounterDiagnosisId
						FROM NHJAX_ODS_ARCHIVE.dbo.ENCOUNTER_DIAGNOSIS_ARCHIVE
						WHERE EncounterDiagnosisId = @ed
						SET @exists = @@RowCount
						
						SET @msged = '@edX:' + CAST(@edX AS varchar(40))
						--EXEC NHJAX_ODS_ARCHIVE.dbo.upActivityLog @msged,0,0;
						
						IF @exists = 0
						BEGIN
						INSERT INTO NHJAX_ODS_ARCHIVE.dbo.ENCOUNTER_DIAGNOSIS_ARCHIVE
						(
							EncounterDiagnosisId,  
							DiagnosisId, 
							Priority, 
							[Description], 
							CreatedDate, 
							UpdatedDate, 
							SourceSystemId,
							PatientEncounterId
						)
						VALUES
						(
							@ed,
							@diag,
							@edpri,
							@desc,
							@edcdate,
							@edcudate,
							@edss,
							@encID
						)
						END --End ED Insert	
										
					FETCH NEXT FROM curED INTO @ed,@diag,@edpri,
					@desc,@edcdate,@edcudate,@edss
					
					END --End While
				END
				CLOSE curED
				DEALLOCATE curED
				
				--Delete ENCOUNTER_DIAGNOSIS
				DELETE FROM ENCOUNTER_DIAGNOSIS
				WHERE EncounterDiagnosisId = @ed
				--PRINT 'Delete ED'
				--EXEC NHJAX_ODS_ARCHIVE.dbo.upActivityLog 'END ED',0,0;
				END --ENCOUNTER_DIAGNOSIS
				
				BEGIN--ENCOUNTER_DIAGNOSIS_FREE_TEXT
			
				Declare @edft bigint
				Declare @edftX bigint
				Declare @edftk numeric(7,3)
				Declare @dft varchar(61)
				Declare @edftcdate datetime
								
				DECLARE curEDFT CURSOR FAST_FORWARD FOR
				SELECT     
					EncounterDiagnosisFreeTextId,  
					EncounterDiagnosisFreeTextKey, 
					DiagnosisFreeText,  
					CreatedDate
				FROM ENCOUNTER_DIAGNOSIS_FREE_TEXT
				WHERE PatientEncounterId = @encID
				
				OPEN curEDFT

				FETCH NEXT FROM curEDFT INTO @edft,@edftk,
					@dft,@edftcdate

				if(@@FETCH_STATUS = 0)
				BEGIN

					--PRINT @encID
					
					WHILE(@@FETCH_STATUS = 0)
					BEGIN
						SELECT @edftX = EncounterDiagnosisFreeTextId
						FROM NHJAX_ODS_ARCHIVE.dbo.ENCOUNTER_DIAGNOSIS_FREE_TEXT_ARCHIVE
						WHERE EncounterDiagnosisFreeTextId = @edft
						SET @exists = @@RowCount
						IF @exists = 0
						BEGIN
						INSERT INTO NHJAX_ODS_ARCHIVE.dbo.ENCOUNTER_DIAGNOSIS_FREE_TEXT_ARCHIVE
						(
							EncounterDiagnosisFreeTextId,  
							EncounterDiagnosisFreeTextKey, 
							DiagnosisFreeText,  
							CreatedDate,
							PatientEncounterId
						)
						VALUES
						(
							@edft,
							@edftk,
							@dft,
							@edftcdate,
							@encID
						)
						END --End EDFT Insert	
										
					FETCH NEXT FROM curEDFT INTO @edft,@edftk,
					@dft,@edftcdate
					
					END --End While
				END
				CLOSE curEDFT
				DEALLOCATE curEDFT
				
				--Delete ENCOUNTER_DIAGNOSIS_FREE_TEXT
				DELETE FROM ENCOUNTER_DIAGNOSIS_FREE_TEXT
				WHERE EncounterDiagnosisFreeTextId = @edft
				
				--PRINT 'Delete EDFT'
				--EXEC NHJAX_ODS_ARCHIVE.dbo.upActivityLog 'END EDFT',0,0;
				
				END --ENCOUNTER_DIAGNOSIS_FREE_TEXT
				
				BEGIN--ENCOUNTER_PROVIDER
			
				Declare @ep bigint
				Declare @epX bigint
				Declare @eppro bigint
				Declare @rol bigint
				Declare @epcdate datetime
								
				DECLARE curEP CURSOR FAST_FORWARD FOR
				SELECT     
					EncounterProviderId,  
					ProviderId, 
					ProviderRoleId,  
					CreatedDate
				FROM ENCOUNTER_PROVIDER
				WHERE PatientEncounterId = @encID
				
				OPEN curEP

				FETCH NEXT FROM curEP INTO @ep,@eppro,
					@rol,@epcdate

				if(@@FETCH_STATUS = 0)
				BEGIN

					--PRINT @encID
					
					WHILE(@@FETCH_STATUS = 0)
					BEGIN
						SELECT @epX = EncounterProviderId
						FROM NHJAX_ODS_ARCHIVE.dbo.ENCOUNTER_PROVIDER_ARCHIVE
						WHERE EncounterProviderId = @ep
						SET @exists = @@RowCount
						IF @exists = 0
						BEGIN
						INSERT INTO NHJAX_ODS_ARCHIVE.dbo.ENCOUNTER_PROVIDER_ARCHIVE
						(
							EncounterProviderId,  
							ProviderId, 
							ProviderRoleId,  
							CreatedDate,
							PatientEncounterId
						)
						VALUES
						(
							@ep,
							@eppro,
							@rol,
							@epcdate,
							@encID
						)
						END --End EP Insert	
										
					FETCH NEXT FROM curEP INTO @ep,@eppro,
					@rol,@epcdate
					
					END --End While
				END
				CLOSE curEP
				DEALLOCATE curEP
				
				--Delete ENCOUNTER_PROVIDER
				DELETE FROM ENCOUNTER_PROVIDER
				WHERE EncounterProviderId = @ep
				
				--PRINT 'Delete EP'
				--EXEC NHJAX_ODS_ARCHIVE.dbo.upActivityLog 'END EP',0,0;
				
				END --ENCOUNTER_PROVIDER
				
				BEGIN--PATIENT_ENCOUNTER_DETAIL_CODE
			
				Declare @dtl bigint
				Declare @dtlX bigint
				Declare @dtlcdate datetime
								
				DECLARE curPEDC CURSOR FAST_FORWARD FOR
				SELECT     
					AppointmentDetailId,  
					CreatedDate
				FROM PATIENT_ENCOUNTER_DETAIL_CODE
				WHERE PatientEncounterId = @encID
				
				OPEN curPEDC

				FETCH NEXT FROM curPEDC INTO @dtl,@dtlcdate

				if(@@FETCH_STATUS = 0)
				BEGIN

					--PRINT @encID
					
					WHILE(@@FETCH_STATUS = 0)
					BEGIN
						SELECT @dtlX = AppointmentDetailId
						FROM NHJAX_ODS_ARCHIVE.dbo.PATIENT_ENCOUNTER_DETAIL_CODE_ARCHIVE
						WHERE AppointmentDetailId = @dtl
						AND PatientEncounterId = @encID
						SET @exists = @@RowCount
						IF @exists = 0
						BEGIN
						INSERT INTO NHJAX_ODS_ARCHIVE.dbo.PATIENT_ENCOUNTER_DETAIL_CODE_ARCHIVE
						(
							AppointmentDetailId,  
							CreatedDate,
							PatientEncounterId
						)
						VALUES
						(
							@dtl,
							@dtlcdate,
							@encID
						)
						END --End PEDC Insert	
										
					FETCH NEXT FROM curPEDC INTO @dtl,@dtlcdate
					
					END --End While
				END
				CLOSE curPEDC
				DEALLOCATE curPEDC
				
				--Delete PATIENT_ENCOUNTER_DETAIL_CODE
				DELETE FROM PATIENT_ENCOUNTER_DETAIL_CODE
				WHERE PatientEncounterId = @encID
				
				--PRINT 'Delete PEDC'
				--EXEC NHJAX_ODS_ARCHIVE.dbo.upActivityLog 'END PEDC',0,0;
				
				END --PATIENT_ENCOUNTER_DETAIL_CODE
				
				--BEGIN--PATIENT_ENCOUNTER_EDPTS
			
				--FUTURE USE
				
				--END --PATIENT_ENCOUNTER_EDPTS
				
				BEGIN--PATIENT_ENCOUNTER_SURGERY
			
				Declare @pes bigint
				Declare @pesX bigint
				Declare @pesref int
				Declare @sdate datetime
				Declare @pre varchar(10)
				Declare @post varchar(10)
				Declare @pescdate datetime
				Declare @pescby int
				Declare @pesudate datetime
				Declare @pesuby int
				Declare @impdate datetime
				Declare @iudate datetime
				Declare @can bit
				Declare @isin bit
								
				DECLARE curPES CURSOR FAST_FORWARD FOR
				SELECT     
					PatientEncounterSurgeryId, 
					ReferenceNumber,
					SurgeryDate,
					PreOpWard,
					PostOpWard,
					CreatedDate,
					CreatedBy,
					UpdatedDate,
					UpdatedBy,
					ImportedDate,
					ImportUpdateDate,
					Cancelled,
					IsInpatient
				FROM PATIENT_ENCOUNTER_SURGERY
				WHERE PatientEncounterId = @encID
				
				OPEN curPES

				FETCH NEXT FROM curPES INTO @pes,@pesref,@sdate,
				@pre,@post,@pescdate,@pescby,@pesudate,@pesuby,
				@impdate,@iudate,@can,@isin

				if(@@FETCH_STATUS = 0)
				BEGIN

					--PRINT @encID
					
					WHILE(@@FETCH_STATUS = 0)
					BEGIN
						SELECT @pesX = PatientEncounterSurgeryId
						FROM NHJAX_ODS_ARCHIVE.dbo.PATIENT_ENCOUNTER_SURGERY_ARCHIVE
						WHERE PatientEncounterSurgeryId = @pes
						SET @exists = @@RowCount
						IF @exists = 0
						BEGIN
						INSERT INTO NHJAX_ODS_ARCHIVE.dbo.PATIENT_ENCOUNTER_SURGERY_ARCHIVE
						(
							PatientEncounterSurgeryId, 
							ReferenceNumber,
							SurgeryDate,
							PreOpWard,
							PostOpWard,
							CreatedDate,
							CreatedBy,
							UpdatedDate,
							UpdatedBy,
							ImportedDate,
							ImportUpdateDate,
							Cancelled,
							IsInpatient,
							PatientEncounterId
						)
						VALUES
						(
							@pes,
							@pesref,
							@sdate,
							@pre,
							@post,
							@pescdate,
							@pescby,
							@pesudate,
							@pesuby,
							@impdate,
							@iudate,
							@can,
							@isin,
							@encID
						)
						END --End PES Insert	
										
					FETCH NEXT FROM curPES INTO @pes,@pesref,@sdate,
					@pre,@post,@pescdate,@pescby,@pesudate,@pesuby,
					@impdate,@iudate,@can,@isin
					
					END --End While
				END
				CLOSE curPES
				DEALLOCATE curPES
				
				--Delete PATIENT_ENCOUNTER_SURGERY
				DELETE FROM PATIENT_ENCOUNTER_SURGERY
				WHERE PatientEncounterId = @encID
				
				--PRINT 'Delete PES'
				--EXEC NHJAX_ODS_ARCHIVE.dbo.upActivityLog 'END PES',0,0;
				
				END --PATIENT_ENCOUNTER_SURGERY
				
				BEGIN--PATIENT_ORDER (requires a separate run)
			
				Declare @po bigint
				Declare @poX bigint
				Declare @okey numeric(14,3)
				Declare @onum varchar(30)
				Declare @popat bigint
				Declare @oetyp bigint
				Declare @otyp bigint
				Declare @poloc bigint
				Declare @popro bigint
				Declare @sig datetime
				Declare @odate datetime
				Declare @cost numeric(17,5)
				Declare @qty numeric(15,5)
				Declare @unit money
				Declare @ocost money
				Declare @oek numeric(21,3)
				Declare @pocdate datetime
				Declare @poudate datetime
				Declare @coll bigint
				Declare @popri bigint
				Declare @poss bigint
				Declare @postat bigint
				Declare @comm varchar(100)
				Declare @ap bigint
				Declare @onumx varchar(35)
				Declare @pocby int
				Declare @pouby int
												
				DECLARE curPO CURSOR FAST_FORWARD FOR
				SELECT     
					OrderId, 
					OrderKey, 
					OrderNumber, 
					PatientId, 
					OrderEncounterTypeId, 
					OrderTypeId, 
					LocationId, 
					OrderingProviderId, 
					SigDateTime, 
					OrderDateTime, 
                    PdtsFillCost, 
                    Quantity, 
                    UnitCost, 
                    OrderCost, 
                    OrderElementKey, 
                    CreatedDate, 
                    UpdatedDate, 
                    CollectionSampleId, 
                    OrderPriorityId, 
                    SourceSystemId, 
                    OrderStatusId, 
                    OrderComment, 
                    AncillaryProcedureId, 
                    OrderNumberExtended, 
                    CreatedBy, 
                    UpdatedBy
				FROM PATIENT_ORDER
				WHERE PatientEncounterId = @encID
				
				OPEN curPO

				FETCH NEXT FROM curPO INTO @po,@okey,@onum,@popat,
				@oetyp,@otyp,@poloc,@popro,@sig,@odate,@cost,
				@qty,@unit,@ocost,@oek,@pocdate,@poudate,@coll,
				@popri,@poss,@postat,@comm,@ap,@onumx,@pocby,@pouby

				if(@@FETCH_STATUS = 0)
				BEGIN

					--PRINT @encID
					
					WHILE(@@FETCH_STATUS = 0)
					BEGIN
						SELECT @poX = OrderId
						FROM NHJAX_ODS_ARCHIVE.dbo.PATIENT_ORDER_ARCHIVE
						WHERE OrderId = @po
						SET @exists = @@RowCount
						IF @exists = 0
						BEGIN
						INSERT INTO NHJAX_ODS_ARCHIVE.dbo.PATIENT_ORDER_ARCHIVE
						(
							OrderId, 
							OrderKey, 
							OrderNumber, 
							PatientId, 
							OrderEncounterTypeId, 
							OrderTypeId, 
							LocationId, 
							OrderingProviderId, 
							SigDateTime, 
							OrderDateTime, 
							PdtsFillCost, 
							Quantity, 
							UnitCost, 
							OrderCost, 
							OrderElementKey, 
							CreatedDate, 
							UpdatedDate, 
							CollectionSampleId, 
							OrderPriorityId, 
							SourceSystemId, 
							OrderStatusId, 
							OrderComment, 
							AncillaryProcedureId, 
							OrderNumberExtended, 
							CreatedBy, 
							UpdatedBy,
							PatientEncounterId
						)
						VALUES
						(
							@po,
							@okey,
							@onum,
							@popat,
							@oetyp,
							@otyp,
							@poloc,
							@popro,
							@sig,
							@odate,
							@cost,
							@qty,
							@unit,
							@ocost,
							@oek,
							@pocdate,
							@poudate,
							@coll,
							@popri,
							@poss,
							@postat,
							@comm,
							@ap,
							@onumx,
							@pocby,
							@pouby,
							@encID
						)
						END --End PO Insert	
										
					FETCH NEXT FROM curPO INTO @po,@okey,@onum,@popat,
					@oetyp,@otyp,@poloc,@popro,@sig,@odate,@cost,
					@qty,@unit,@ocost,@oek,@pocdate,@poudate,@coll,
					@popri,@poss,@postat,@comm,@ap,@onumx,@pocby,@pouby
					
					END --End While
				END
				CLOSE curPO
				DEALLOCATE curPO
				
				--Delete PATIENT_ORDER
				DELETE FROM PATIENT_ORDER
				WHERE PatientEncounterId = @encID
				
				--PRINT 'Delete PO'
				--EXEC NHJAX_ODS_ARCHIVE.dbo.upActivityLog 'END PO',0,0;
				
				END --PATIENT_ORDER
				
				BEGIN--PATIENT_PROCEDURE
			
				Declare @pp bigint
				Declare @ppX bigint
				Declare @ppkey numeric(8,3)
				Declare @cpt bigint
				Declare @pptyp bigint
				Declare @dpri numeric(10,3)
				Declare @pdate datetime
				Declare @surg bigint
				Declare @anes bigint
				Declare @ppdesc varchar(100)
				Declare @ppcdate datetime
				Declare @ppudate datetime
				Declare @rvu money
				Declare @ppss bigint
												
				DECLARE curPP CURSOR FAST_FORWARD FOR
				SELECT  ProcedureId, 
					ProcedureKey, 
					CptId, 
					ProcedureTypeId, 
					DiagnosisPriorities, 
					ProcedureDateTime, 
					SurgeonId, 
					AnesthetistId, 
                    ProcedureDesc, 
                    CreatedDate, 
                    UpdatedDate, 
                    RVU, 
                    SourceSystemId
	         	FROM PATIENT_PROCEDURE
				WHERE PatientEncounterId = @encID
				
				OPEN curPP

				FETCH NEXT FROM curPP INTO @pp,@ppkey,@cpt,@pptyp,
				@dpri,@pdate,@surg,@anes,@ppdesc,@ppcdate,@ppudate,
				@rvu,@ppss

				if(@@FETCH_STATUS = 0)
				BEGIN

					--PRINT @encID
					
					WHILE(@@FETCH_STATUS = 0)
					BEGIN
						SELECT @ppX = ProcedureId
						FROM NHJAX_ODS_ARCHIVE.dbo.PATIENT_PROCEDURE_ARCHIVE
						WHERE ProcedureId = @pp
						SET @exists = @@RowCount
						IF @exists = 0
						BEGIN
						INSERT INTO NHJAX_ODS_ARCHIVE.dbo.PATIENT_PROCEDURE_ARCHIVE
						(
							ProcedureId, 
							ProcedureKey, 
							CptId, 
							ProcedureTypeId, 
							DiagnosisPriorities, 
							ProcedureDateTime, 
							SurgeonId, 
							AnesthetistId, 
							ProcedureDesc, 
							CreatedDate, 
							UpdatedDate, 
							RVU, 
							SourceSystemId,
							PatientEncounterId
						)
						VALUES
						(
							@pp,
							@ppkey,
							@cpt,
							@pptyp,
							@dpri,
							@pdate,
							@surg,
							@anes,
							@ppdesc,
							@ppcdate,
							@ppudate,
							@rvu,
							@ppss,
							@encID
						)
						END --End PP Insert	
										
					FETCH NEXT FROM curPP INTO @pp,@ppkey,@cpt,@pptyp,
					@dpri,@pdate,@surg,@anes,@ppdesc,@ppcdate,@ppudate,
					@rvu,@ppss
					
					END --End While
					
				END
				CLOSE curPP
				DEALLOCATE curPP
				
				--Delete PATIENT_PROCEDURE
				DELETE FROM PATIENT_PROCEDURE
				WHERE PatientEncounterId = @encID
				--PRINT 'Delete PP'
				END --PATIENT_PROCEDURE
				
				BEGIN--VITAL
			
				Declare @vit bigint
				Declare @vitX bigint
				Declare @vtyp int
				Declare @res varchar(50)
				Declare @vitcdate datetime
				Declare @bmi int
																
				DECLARE curVIT CURSOR FAST_FORWARD FOR
				SELECT  VitalId, 
					VitalTypeId, 
					Result, 
                    CreatedDate, 
                    ResultBMI
	         	FROM VITAL
				WHERE PatientEncounterId = @encID
				
				OPEN curVIT

				FETCH NEXT FROM curVIT INTO @vit,@vtyp,@res,
				@vitcdate,@bmi

				if(@@FETCH_STATUS = 0)
				BEGIN

					--PRINT @encID
					
					WHILE(@@FETCH_STATUS = 0)
					BEGIN
						SELECT @vitX = VitalId
						FROM NHJAX_ODS_ARCHIVE.dbo.VITAL_ARCHIVE
						WHERE VitalId = @vit
						SET @exists = @@RowCount
						IF @exists = 0
						BEGIN
						INSERT INTO NHJAX_ODS_ARCHIVE.dbo.VITAL_ARCHIVE
						(
							VitalId, 
							VitalTypeId, 
							Result, 
							CreatedDate, 
							ResultBMI,
							PatientEncounterId
						)
						VALUES
						(
							@vit,
							@vtyp,
							@res,
							@vitcdate,
							@bmi,
							@encID
						)
						END --End VIT Insert	
					
					
					FETCH NEXT FROM curVIT INTO @vit,@vtyp,@res,
					@vitcdate,@bmi
					
					END --End While
				END
				CLOSE curVIT
				DEALLOCATE curVIT
				
				--Delete VITAL
				DELETE FROM VITAL
				WHERE PatientEncounterId = @encID
				--PRINT 'Delete VITAL'
				END --VITAL
			
			--Finalize Encounter with delete
			DELETE FROM PATIENT_ENCOUNTER
			WHERE PatientEncounterId = @encID
			--PRINT 'Delete'
			
	FETCH NEXT FROM curArch INTO @encID,@appt,@enc,@pat,@date,@loc,
	@pro,@duration,@stat,@reason,@disp,@type,@ref,@adm,@dis,@cdate,
	@udate,@made,@atc,@datc,@pri,@ss,@ac,@seen,@rel,@drel,@mep,@non,
	@cdm,@dmis,@ssk,@er
	
	COMMIT	
	END

END
CLOSE curArch
DEALLOCATE curArch
EXEC NHJAX_ODS_ARCHIVE.dbo.upActivityLog 'End Patient_Encounter_Archive',0,0;
END