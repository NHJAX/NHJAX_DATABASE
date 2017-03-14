CREATE TABLE [dbo].[PATIENT_ADMISSION] (
    [PatientAdmissionId]        BIGINT          IDENTITY (1, 1) NOT NULL,
    [PatientAdmissionKey]       NUMERIC (8, 3)  NULL,
    [PatientId]                 BIGINT          NULL,
    [AdmissionTypeId]           BIGINT          NULL,
    [DischargeTypeId]           BIGINT          NULL,
    [AdmittingPhysicianId]      BIGINT          NULL,
    [AttendingPhysicianId]      BIGINT          NULL,
    [DispositioningPhysicianId] BIGINT          NULL,
    [AdmissionDate]             DATETIME        NULL,
    [DischargeDate]             DATETIME        NULL,
    [SameDaySurgery]            VARCHAR (3)     CONSTRAINT [DF_PATIENT_ADMISSION_SameDaySurgery] DEFAULT ('N/A') NULL,
    [CreatedDate]               DATETIME        CONSTRAINT [DF_PATIENT_ADMISSION_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]               DATETIME        CONSTRAINT [DF_PATIENT_ADMISSION_UpdatedDate] DEFAULT (getdate()) NULL,
    [EncounterKey]              NUMERIC (13, 3) NULL,
    [DispositionOrder]          NUMERIC (21, 3) NULL,
    [SourceSystemId]            BIGINT          CONSTRAINT [DF_PATIENT_ADMISSION_SourceSystemId] DEFAULT ((0)) NULL,
    [HospitalLocationId]        BIGINT          NULL,
    [DiagnosisAtAdmissionId]    BIGINT          NULL,
    [AdmittingServiceId]        BIGINT          NULL,
    [AdmissionOrderKey]         NUMERIC (21, 3) NULL,
    [AdmissionEmailProcessed]   BIT             NULL,
    [DischargeEmailProcessed]   BIT             NULL,
    CONSTRAINT [PK_PATIENT_ADMISSION] PRIMARY KEY CLUSTERED ([PatientAdmissionId] ASC),
    CONSTRAINT [FK_PATIENT_ADMISSION_ADMISSION_TYPE] FOREIGN KEY ([AdmissionTypeId]) REFERENCES [dbo].[ADMISSION_TYPE] ([AdmissionTypeId]),
    CONSTRAINT [FK_PATIENT_ADMISSION_DISCHARGE_TYPE] FOREIGN KEY ([DischargeTypeId]) REFERENCES [dbo].[DISCHARGE_TYPE] ([DischargeTypeId]),
    CONSTRAINT [FK_PATIENT_ADMISSION_PATIENT] FOREIGN KEY ([PatientId]) REFERENCES [dbo].[PATIENT] ([PatientId]),
    CONSTRAINT [FK_PATIENT_ADMISSION_PROVIDER] FOREIGN KEY ([AdmittingPhysicianId]) REFERENCES [dbo].[PROVIDER] ([ProviderId]),
    CONSTRAINT [FK_PATIENT_ADMISSION_PROVIDER1] FOREIGN KEY ([AttendingPhysicianId]) REFERENCES [dbo].[PROVIDER] ([ProviderId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_PATIENT_ADMISSION_PatientAdmissionKey_PatientId]
    ON [dbo].[PATIENT_ADMISSION]([PatientAdmissionKey] ASC, [PatientId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ADMISSION_EncounterKey]
    ON [dbo].[PATIENT_ADMISSION]([EncounterKey] ASC);


GO
CREATE TRIGGER [dbo].[AdmissionsDischargesNotifications] ON [dbo].[PATIENT_ADMISSION]
WITH EXEC AS CALLER
AFTER INSERT, UPDATE
AS
DECLARE @PatientAdmissionId int
DECLARE @PatientId int
DECLARE @ProviderId int
DECLARE @HospitalLocationId int
DECLARE @HospitalLocationDesc varchar(36)
DECLARE @AdmissionEmailProcessed bit
DECLARE @DischargeEmailProcessed bit
DECLARE @AdmissionDate datetime
DECLARE @DischargeDate datetime
DECLARE @AdmissionTypeId bigint
DECLARE @AdmissionTypeDesc varchar(62)
DECLARE @DischargeTypeId bigint
DECLARE @DischargeTypeDesc varchar(60)
DECLARE @nosend bit
DECLARE @PatientFullName varchar(32)
DECLARE @PatientGender varchar(30)
DECLARE @PatientDOB datetime
DECLARE @FMP bigint
DECLARE @SponsorSSN varchar(15)
DECLARE @PCMEmail varchar(255)
DECLARE @ProviderEnetId int
DECLARE @ProviderEmailAddress varchar(255)
DECLARE @EmailSubject varchar(255)
DECLARE @EmailBody nvarchar(max)
DECLARE @EmailType int
DECLARE @SendEmail bit
DECLARE @TestEmailAddress varchar(255)
BEGIN
	--**************************************************************
	--******    CHANGE LOG                                     *****
	----------------------------------------------------------------
	--* 2015-03-10 Added FOUO to email messages.
	--
	--**************************************************************
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--EXEC dbo.upActivityLog 'Admissions/Discharges EMail Trigger Fired!',10001
	--**************************************************************
	--******    B E G I N   T R Y  C A T C H                   *****
	--**************************************************************
BEGIN TRY
	SET @nosend = 1
	SET @EmailSubject = ''
	SET @EmailBody = ''
	SET @EmailType = 0
	SET @SendEmail = 0
	SET @ProviderEmailAddress = ''
	SET @TestEmailAddress = 'kristopher.s.kern.ctr@mail.mil'
	--Remove or Comment Out the below for production for test only
	--SET @SendEmail = 1
	--Remove or Comment Out the above for production for test only
	SELECT 	 @PatientAdmissionId 		= ISNULL(PatientAdmissionId,0)
			,@PatientId 				= ISNULL(PatientId,0)
			,@AdmissionTypeId 			= ISNULL(AdmissionTypeId,0)
			,@DischargeTypeId  			= ISNULL(DischargeTypeId,0) 
			,@AdmissionDate 			= AdmissionDate 
			,@DischargeDate 			= DischargeDate 
			,@HospitalLocationId 		= ISNULL(HospitalLocationId,0) 
			,@AdmissionEmailProcessed 	= ISNULL(AdmissionEmailProcessed,0) 
			,@DischargeEmailProcessed 	= ISNULL(DischargeEmailProcessed,0) 
	FROM inserted
	--EXEC dbo.upActivityLog 'Admissions/Discharges EMail Trigger STEP 1!',10001
--*****************************************************************************************************************************************
--********************************    PROCESS ADMISSION DATE FIRST BECAUSE IT SHOULD COME FIRST  ******************************************
--*****************************************************************************************************************************************
	IF (@AdmissionDate IS NOT NULL)
		BEGIN
			--EXEC dbo.upActivityLog 'Admissions/Discharges EMail Trigger ASTEP 2!',10001
			-- This check is to elimnate the 1900's dates
			IF (DATEDIFF(d,@AdmissionDate,getdate()) < 180)
				BEGIN
					--EXEC dbo.upActivityLog 'Admissions/Discharges EMail Trigger ASTEP 3!',10001
					IF (@AdmissionEmailProcessed = 0)
						BEGIN
							--EXEC dbo.upActivityLog 'Admissions/Discharges EMail Trigger ASTEP 4!',10001
							--******************************************
							--******** PROCESS THE ADMISSION ***********
							--******************************************
							SELECT @AdmissionTypeDesc = AdmissionTypeDesc 
							FROM ADMISSION_TYPE WHERE AdmissionTypeId = @AdmissionTypeId
							
							SELECT TOP 1 @ProviderId = ProviderId 
							FROM PRIMARY_CARE_MANAGER
							WHERE PatientID = @PatientId
							ORDER BY PCMEnrollmentDate DESC

							SELECT @ProviderEmailAddress = ISNULL(TECH.EMailAddress, 'kristopher.s.kern.ctr@mail.mil'),
							@ProviderEnetId = TECH.UserId
							FROM	PROVIDER AS PRO 
							INNER JOIN PRIMARY_CARE_MANAGER AS PCM 
							ON PRO.ProviderId = PCM.ProviderId 
							LEFT OUTER JOIN vwENET_TECHNICIAN AS TECH 
							ON PRO.ProviderSSN = TECH.SSN
							WHERE PRO.ProviderId = @ProviderId
							
							SELECT @HospitalLocationDesc = HospitalLocationDesc
							FROM HOSPITAL_LOCATION WHERE HospitalLocationId = @HospitalLocationId
							
							SELECT   @PatientFullName = FullName
									,@PatientGender = Sex
									,@PatientDOB = DOB
									,@FMP = FamilyMemberPrefixId
									,@SponsorSSN = SponsorSSN
							FROM PATIENT
							WHERE PatientId = @PatientId
							
							SET @EmailSubject = '***FOUO*** Patient Admission Notification'
							SET @EmailType = 1
							IF @ProviderEmailAddress <> ''
								BEGIN
									SET @SendEmail = 1
									SET @EmailBody = @EmailBody + CHAR(13)
									SET @EmailBody = @EmailBody + 'A Patient of yours has been admitted to the Hospital' --'Patient Name: ' + @PatientFullName 
									SET @EmailBody = @EmailBody + CHAR(13)
									SET @EmailBody = @EmailBody + 'Patient Birth Year: ' + CONVERT(VARCHAR(4),DATEPART(yyyy,@PatientDOB))
									SET @EmailBody = @EmailBody + CHAR(13)
									SET @EmailBody = @EmailBody + 'Gender: ' + @PatientGender
									SET @EmailBody = @EmailBody + CHAR(13)
									SET @EmailBody = @EmailBody + 'Reason: ' + @AdmissionTypeDesc
									SET @EmailBody = @EmailBody + CHAR(13)
									SET @EmailBody = @EmailBody + 'Hospital Location: ' + @HospitalLocationDesc

									SET @EmailBody = @EmailBody + CHAR(13) + CHAR(13)
									SET @EmailBody = @EmailBody + 'Please follow this link for patient details: '
									SET @EmailBody = @EmailBody + CHAR(13)
									SET @EmailBody = @EmailBody + 'https://nhjax-webapps-01/clinicalportal2/Provider.aspx?PatientId=' + CAST(@PatientId AS varchar(20))

									
									SET @EmailBody = @EmailBody + CHAR(13) + CHAR(13)
									SET @EmailBody = @EmailBody + 'Please review this information for accuracy.  '
									SET @EmailBody = @EmailBody + 'If you find any errors in this alert, '
									SET @EmailBody = @EmailBody + 'please contact MID at 542-7577 '
									SET @EmailBody = @EmailBody + 'or put in a Help Desk Ticket at: ' + CHAR(13) + CHAR(13)
									SET @EmailBody = @EmailBody + 'https://nhjax-webapps-01/enet/default.aspx'

									SET @EmailBody = @EmailBody + CHAR(13) + CHAR(13)
									SET @EmailBody = @EmailBody + 'This electronic mail and any attachments may '
									SET @EmailBody = @EmailBody + 'contain information that is subject to the '
									SET @EmailBody = @EmailBody + 'Privacy Act of 1974 and the Health Insurance '
									SET @EmailBody = @EmailBody + 'Portability and Accountability Act (HIPAA) of 1996. '
									SET @EmailBody = @EmailBody + 'Use and disclosure of protected health '
									SET @EmailBody = @EmailBody + 'information is for OFFICIAL USE ONLY, '
									SET @EmailBody = @EmailBody + 'and must be in compliance with these statutes. '
									SET @EmailBody = @EmailBody + 'If you have inadvertently received this e-mail, '
									SET @EmailBody = @EmailBody + 'please notify the sender and delete the data '
									SET @EmailBody = @EmailBody + 'without forwarding it or making any copies.'

									IF @SendEmail > 0
										BEGIN
											EXEC dbo.upActivityLog 'Sending Admission EMail',10001
											EXEC dbo.upSendMail @EmailSubject, @EmailBody, @ProviderEmailAddress
											UPDATE PATIENT_ADMISSION SET AdmissionEmailProcessed = 1 WHERE PatientAdmissionId = @PatientAdmissionId
										END
								END
						END
				END
		END
--*****************************************************************************************************************************************
--******************************************    PROCESS DISCHARGE DATE SECOND  ***********************************************************
--*****************************************************************************************************************************************
	IF (@DischargeDate IS NOT NULL)
		BEGIN
			--EXEC dbo.upActivityLog 'Admissions/Discharges EMail Trigger DSTEP 2!',10001
			-- This check is to elimnate the 1900's dates
			IF (DATEDIFF(d,@DischargeDate,getdate()) < 180)
				BEGIN
					--EXEC dbo.upActivityLog 'Admissions/Discharges EMail Trigger STEP 3!',10001
					IF (@DischargeEmailProcessed = 0)
						BEGIN
							--EXEC dbo.upActivityLog 'Admissions/Discharges EMail Trigger STEP 4!',10001
							--******************************************
							--******** PROCESS THE DISCHARGE ***********
							--******************************************
							SELECT @DischargeTypeDesc = DischargeTypeDesc 
							FROM DISCHARGE_TYPE WHERE DischargeTypeId = @DischargeTypeId
							
							SELECT TOP 1 @ProviderId = ProviderId 
							FROM PRIMARY_CARE_MANAGER
							WHERE PatientID = @PatientId
							ORDER BY PCMEnrollmentDate DESC

							SELECT @ProviderEmailAddress = ISNULL(TECH.EMailAddress, 'kristopher.s.kern.ctr@mail.mil'),
							@ProviderEnetId = TECH.UserId
							FROM	PROVIDER AS PRO 
							INNER JOIN PRIMARY_CARE_MANAGER AS PCM 
							ON PRO.ProviderId = PCM.ProviderId 
							LEFT OUTER JOIN vwENET_TECHNICIAN AS TECH 
							ON PRO.ProviderSSN = TECH.SSN
							WHERE PRO.ProviderId = @ProviderId
							
							SELECT @HospitalLocationDesc = HospitalLocationDesc
							FROM HOSPITAL_LOCATION WHERE HospitalLocationId = @HospitalLocationId
							
							SELECT   @PatientFullName = FullName
									,@PatientGender = Sex
									,@PatientDOB = DOB
									,@FMP = FamilyMemberPrefixId
									,@SponsorSSN = SponsorSSN
							FROM PATIENT
							WHERE PatientId = @PatientId
							
							SET @EmailSubject = '***FOUO*** Patient Discharge Notification'
							SET @EmailType = 1
							IF @ProviderEmailAddress <> ''
								BEGIN
									SET @SendEmail = 1
									SET @EmailBody = @EmailBody + CHAR(13)
									SET @EmailBody = @EmailBody + 'A Patient of yours has been discharged from the Hospital' --'Patient Name: ' + @PatientFullName 
									SET @EmailBody = @EmailBody + CHAR(13)
									SET @EmailBody = @EmailBody + 'Patient Birth Year: ' + CONVERT(VARCHAR(4),DATEPART(yyyy,@PatientDOB))
									SET @EmailBody = @EmailBody + CHAR(13)
									SET @EmailBody = @EmailBody + 'Gender: ' + @PatientGender
									SET @EmailBody = @EmailBody + CHAR(13)
									SET @EmailBody = @EmailBody + 'Reason: ' + @DischargeTypeDesc
									SET @EmailBody = @EmailBody + CHAR(13)
									SET @EmailBody = @EmailBody + 'Hospital Location: ' + @HospitalLocationDesc

									SET @EmailBody = @EmailBody + CHAR(13) + CHAR(13)
									SET @EmailBody = @EmailBody + 'Please follow this link for patient details: '
									SET @EmailBody = @EmailBody + CHAR(13)
									SET @EmailBody = @EmailBody + 'https://nhjax-webapps-01/clinicalportal2/Provider.aspx?PatientId=' + CAST(@PatientId AS varchar(20))

									SET @EmailBody = @EmailBody + CHAR(13) + CHAR(13)
									SET @EmailBody = @EmailBody + 'Please review this information for accuracy.  '
									SET @EmailBody = @EmailBody + 'If you find any errors in this alert, '
									SET @EmailBody = @EmailBody + 'please contact MID at 542-7577 '
									SET @EmailBody = @EmailBody + 'or put in a Help Desk Ticket at: ' + CHAR(13) + CHAR(13)
									SET @EmailBody = @EmailBody + 'https://nhjax-webapps-01/enet/default.aspx'

									SET @EmailBody = @EmailBody + CHAR(13) + CHAR(13)
									SET @EmailBody = @EmailBody + 'This electronic mail and any attachments may '
									SET @EmailBody = @EmailBody + 'contain information that is subject to the '
									SET @EmailBody = @EmailBody + 'Privacy Act of 1974 and the Health Insurance '
									SET @EmailBody = @EmailBody + 'Portability and Accountability Act (HIPAA) of 1996. '
									SET @EmailBody = @EmailBody + 'Use and disclosure of protected health '
									SET @EmailBody = @EmailBody + 'information is for OFFICIAL USE ONLY, '
									SET @EmailBody = @EmailBody + 'and must be in compliance with these statutes. '
									SET @EmailBody = @EmailBody + 'If you have inadvertently received this e-mail, '
									SET @EmailBody = @EmailBody + 'please notify the sender and delete the data '
									SET @EmailBody = @EmailBody + 'without forwarding it or making any copies.'

									IF @SendEmail > 0
										BEGIN
											EXEC dbo.upActivityLog 'Sending Discharge EMail',10001
											EXEC dbo.upSendMail @EmailSubject, @EmailBody, @ProviderEmailAddress
											UPDATE PATIENT_ADMISSION SET DischargeEmailProcessed = 1 WHERE PatientAdmissionId = @PatientAdmissionId
										END
								END
						END
				END
		END			
END TRY
BEGIN CATCH
	EXECUTE usp_GetErrorInfo
	EXEC dbo.upActivityLog 'ERROR Sending Discharge Or Admission EMail',10001;
END CATCH
	--**************************************************************
	--******    E N D   T R Y  C A T C H                       *****
	--**************************************************************
END