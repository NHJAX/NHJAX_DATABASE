CREATE TABLE [dbo].[PATIENT_ENCOUNTER] (
    [PatientEncounterId]       BIGINT          IDENTITY (1, 1) NOT NULL,
    [PatientAppointmentKey]    NUMERIC (14, 3) NULL,
    [EncounterKey]             NUMERIC (13, 3) NULL,
    [PatientId]                BIGINT          NULL,
    [AppointmentDateTime]      DATETIME        NULL,
    [HospitalLocationId]       BIGINT          NULL,
    [ProviderId]               BIGINT          NULL,
    [Duration]                 NUMERIC (11, 3) NULL,
    [AppointmentStatusId]      BIGINT          NULL,
    [ReasonForAppointment]     VARCHAR (80)    NULL,
    [PatientDispositionId]     BIGINT          NULL,
    [AppointmentTypeId]        BIGINT          NULL,
    [ReferralId]               BIGINT          NULL,
    [AdmissionDateTime]        DATETIME        NULL,
    [DischargeDateTime]        DATETIME        NULL,
    [CreatedDate]              DATETIME        CONSTRAINT [DF_PATIENT_APPOINTMENT_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]              DATETIME        CONSTRAINT [DF_PATIENT_ENCOUNTER_UpdatedDate] DEFAULT (getdate()) NULL,
    [DateAppointmentMade]      DATETIME        NULL,
    [AccessToCareId]           BIGINT          NULL,
    [AccessToCareDate]         DATETIME        NULL,
    [PriorityId]               BIGINT          NULL,
    [SourceSystemId]           BIGINT          CONSTRAINT [DF_PATIENT_ENCOUNTER_SourceSystemId] DEFAULT ((0)) NULL,
    [ArrivalCategoryId]        BIGINT          NULL,
    [ReasonSeenId]             INT             NULL,
    [ReleaseConditionId]       BIGINT          CONSTRAINT [DF_PATIENT_ENCOUNTER_ReleaseConditionId] DEFAULT ((0)) NULL,
    [ReleaseDateTime]          DATETIME        NULL,
    [MeprsCodeId]              BIGINT          NULL,
    [IsNonCount]               BIT             CONSTRAINT [DF_PATIENT_ENCOUNTER_IsNonCount] DEFAULT ((0)) NULL,
    [CDMAppointmentId]         FLOAT (53)      NULL,
    [DMISId]                   BIGINT          CONSTRAINT [DF_PATIENT_ENCOUNTER_DMISId] DEFAULT ((2011)) NULL,
    [SourceSystemKey]          VARCHAR (50)    NULL,
    [EREntryNumber]            VARCHAR (30)    NULL,
    [ThirdPartyPayerId]        INT             CONSTRAINT [DF_PATIENT_ENCOUNTER_ThirdPartyPayer] DEFAULT ((2)) NULL,
    [WalkInId]                 INT             CONSTRAINT [DF_PATIENT_ENCOUNTER_WalkInId] DEFAULT ((0)) NULL,
    [PatientCancelledReasonId] INT             CONSTRAINT [DF_PATIENT_ENCOUNTER_PatientCancelledReasonId] DEFAULT ((0)) NULL,
    [CancelledBy]              BIGINT          NULL,
    [CancellationDateTime]     DATETIME        NULL,
    [AppointmentComment]       VARCHAR (4000)  NULL,
    CONSTRAINT [PK_PATIENT_APPOINTMENT] PRIMARY KEY NONCLUSTERED ([PatientEncounterId] ASC)
);


GO
CREATE CLUSTERED INDEX [IX_PATIENT_ENCOUNTER_AppointmentDateTime]
    ON [dbo].[PATIENT_ENCOUNTER]([AppointmentDateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_APPOINTMENT_KEY]
    ON [dbo].[PATIENT_ENCOUNTER]([PatientAppointmentKey] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ENCOUNTER]
    ON [dbo].[PATIENT_ENCOUNTER]([EncounterKey] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ENCOUNTER_PATIENT_ID]
    ON [dbo].[PATIENT_ENCOUNTER]([PatientId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ENCOUNTER_PROVIDER_ID]
    ON [dbo].[PATIENT_ENCOUNTER]([ProviderId] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_PATIENT_ENCOUNTER_PatientAppointmentKey_EncounterKey]
    ON [dbo].[PATIENT_ENCOUNTER]([PatientAppointmentKey] ASC, [EncounterKey] ASC, [SourceSystemId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ENCOUNTER_HospitalLocationId]
    ON [dbo].[PATIENT_ENCOUNTER]([HospitalLocationId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ENCOUNTER_AppointmentStatusId]
    ON [dbo].[PATIENT_ENCOUNTER]([AppointmentStatusId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ENCOUNTER_PatientDispositionId]
    ON [dbo].[PATIENT_ENCOUNTER]([PatientDispositionId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ENCOUNTER_AppointmentTypeId]
    ON [dbo].[PATIENT_ENCOUNTER]([AppointmentTypeId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ENCOUNTER_ReferralId]
    ON [dbo].[PATIENT_ENCOUNTER]([ReferralId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ENCOUNTER_AdmissionDateTime]
    ON [dbo].[PATIENT_ENCOUNTER]([AdmissionDateTime] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ENCOUNTER_SourceSystemId]
    ON [dbo].[PATIENT_ENCOUNTER]([SourceSystemId] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ENCOUNTER_ReleaseconditionId]
    ON [dbo].[PATIENT_ENCOUNTER]([ReleaseConditionId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ENCOUNTER_ReleaseDateTime]
    ON [dbo].[PATIENT_ENCOUNTER]([ReleaseDateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ENCOUNTER_MepersCodeId]
    ON [dbo].[PATIENT_ENCOUNTER]([MeprsCodeId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ENCOUNTER_PatientAppointmentKey_SourceSystemId]
    ON [dbo].[PATIENT_ENCOUNTER]([PatientAppointmentKey] ASC, [SourceSystemId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ENCOUNTER_PATIENTENCOUNTERID]
    ON [dbo].[PATIENT_ENCOUNTER]([PatientEncounterId] ASC, [SourceSystemId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ENCOUNTER_MULTIPLE_FIELDS_FOR_CP]
    ON [dbo].[PATIENT_ENCOUNTER]([PatientEncounterId] ASC, [PatientAppointmentKey] ASC, [EncounterKey] ASC, [PatientId] ASC, [AppointmentDateTime] ASC, [HospitalLocationId] ASC, [ProviderId] ASC, [Duration] ASC, [AppointmentStatusId] ASC, [ReasonForAppointment] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ENCOUNTER_PatientEncounterId,PatientId]
    ON [dbo].[PATIENT_ENCOUNTER]([PatientEncounterId] ASC, [PatientId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ENCOUNTER_PatientId]
    ON [dbo].[PATIENT_ENCOUNTER]([PatientId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ENCOUNTER_CDMAppointmentId]
    ON [dbo].[PATIENT_ENCOUNTER]([CDMAppointmentId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ENCOUNTER_PatientId_AppointmentDateTime]
    ON [dbo].[PATIENT_ENCOUNTER]([PatientId] ASC, [AppointmentDateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ENCOUNTER_IsNonCount]
    ON [dbo].[PATIENT_ENCOUNTER]([IsNonCount] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ENCOUNTER_SourceSystemKey]
    ON [dbo].[PATIENT_ENCOUNTER]([SourceSystemKey] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ENCOUNTER_MultiKeyforCube]
    ON [dbo].[PATIENT_ENCOUNTER]([AppointmentDateTime] ASC, [HospitalLocationId] ASC, [AppointmentStatusId] ASC, [SourceSystemId] ASC, [IsNonCount] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ENCOUNTER_DW]
    ON [dbo].[PATIENT_ENCOUNTER]([AppointmentDateTime] ASC)
    INCLUDE([PatientEncounterId], [PatientId], [HospitalLocationId]);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ENCOUNTER_ReasonforAppointment]
    ON [dbo].[PATIENT_ENCOUNTER]([ReasonForAppointment] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ENCOUNTER_SourceSystemId_CDMAppointmentId]
    ON [dbo].[PATIENT_ENCOUNTER]([SourceSystemId] ASC, [CDMAppointmentId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ENCOUNTER_EncounterKey]
    ON [dbo].[PATIENT_ENCOUNTER]([EncounterKey] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ENCOUNTER_MultiKeyforETL]
    ON [dbo].[PATIENT_ENCOUNTER]([EncounterKey] ASC)
    INCLUDE([PatientEncounterId], [PatientAppointmentKey], [PatientId], [AppointmentDateTime], [HospitalLocationId], [ProviderId], [Duration], [AppointmentStatusId], [ReasonForAppointment], [PatientDispositionId], [AppointmentTypeId], [ReferralId], [AdmissionDateTime], [DischargeDateTime], [DateAppointmentMade], [AccessToCareId], [AccessToCareDate], [PriorityId], [SourceSystemId], [ArrivalCategoryId], [ReleaseConditionId], [MeprsCodeId], [DMISId]);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ENCOUNTER_EREntryNumber]
    ON [dbo].[PATIENT_ENCOUNTER]([EREntryNumber] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_ENCOUNTER_HospitalStatusDisposition]
    ON [dbo].[PATIENT_ENCOUNTER]([HospitalLocationId] ASC, [AppointmentStatusId] ASC, [PatientDispositionId] ASC);


GO


CREATE TRIGGER [EDPTS_Patient_Notification_TEST]
   ON  [dbo].[PATIENT_ENCOUNTER]
   FOR INSERT
AS 
DECLARE @loc bigint
DECLARE @pe bigint
DECLARE @msg varchar(1500)
DECLARE @sub varchar(100)
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--SELECT @loc = HospitalLocationId, @pe = PatientEncounterId FROM inserted

SET @loc = 174
SET @pe = 2702460
--SET @pe = 2724321

--Send Mail if ER visit
If @loc = 174
	BEGIN
		--Gather Data about ER Visit
		DECLARE @pcmMail varchar(200)
		DECLARE @pat varchar(32)
		DECLARE @phone varchar(15)
		DECLARE @l4 varchar(4)
		DECLARE @dt datetime
		DECLARE @pro varchar(30)
		DECLARE @stat varchar(30)
		DECLARE @pri varchar(30)
		DECLARE @ac varchar(30)
		DECLARE @pid bigint
		DECLARE @flag int

		--Set default for pcmMail
		SET @pcmMail = 'nopcm'

		SELECT
			@pid = PAT.PatientId, 
			@pat = PAT.FullName, 
			@phone = ISNULL(PAT.Phone,'--'),
			@l4 = ISNULL(RIGHT(PAT.SSN, 4), 'UNK'),
			@dt = ENC.AppointmentDateTime,  
			@pro = PRO.ProviderName,
			@stat = STAT.AppointmentStatusDesc,  
			@pri = PRI.PriorityDesc, 
			@ac = AC.ArrivalCategoryDesc,
			@flag = ISNULL(PFLAG.FlagId,0)                   
		FROM    PATIENT_ENCOUNTER AS ENC 
			INNER JOIN PATIENT AS PAT 
			ON ENC.PatientId = PAT.PatientId 
			INNER JOIN APPOINTMENT_STATUS AS STAT 
			ON ENC.AppointmentStatusId = STAT.AppointmentStatusId 
			INNER JOIN PROVIDER AS PRO 
			ON ENC.ProviderId = PRO.ProviderId 
			INNER JOIN PRIORITY AS PRI 
			ON ENC.PriorityId = PRI.PriorityId 
			INNER JOIN ARRIVAL_CATEGORY AS AC 
			ON ENC.ArrivalCategoryId = AC.ArrivalCategoryId
			LEFT OUTER JOIN vwCP_PATIENT_FLAG AS PFLAG
			ON PAT.PatientId = PFLAG.PatientId
		WHERE (ENC.PatientEncounterId = @pe)

		-- Get EMail Address for PCM
		SELECT @pcmMail = ISNULL(TECH.EMailAddress, 'sean.kern.ctr@med.navy.mil')
		FROM	PROVIDER AS PRO 
		INNER JOIN PRIMARY_CARE_MANAGER AS PCM 
		ON PRO.ProviderId = PCM.ProviderId 
		LEFT OUTER JOIN vwENET_TECHNICIAN AS TECH 
		ON PRO.ProviderSSN = TECH.SSN
		WHERE PCM.PatientId = @pid
		AND PRO.ProviderId NOT IN 
		(
			SELECT PCMExceptionId 
			FROM PCM_EXCEPTION
		)

		PRINT @pcmMail

		--If @pcmMail is still 'nopcm' then change subject
		IF @pcmMail = 'nopcm'
			BEGIN
				SET @Sub = 'NOPCM Notification for ' + @pat + ' on ' + CAST(getdate() AS varchar(50))
			END
		ELSE
			BEGIN
				SET @Sub = 'At Risk ER Visit Notification'
			END

		IF @flag > 0
				BEGIN
				SET @Msg = 'An At Risk patients has been seen in the ER and is enrolled to your panel:'
				--SET @Msg = @Msg + CAST(@pe AS varchar(50))
				END
--		ELSE IF @flag = 2 
--				BEGIN
--				SET @Msg = 'The Diabetic Patient cited below has been seen in the ER and is enrolled to your panel:'
--				END

		SET @Msg = @Msg + CHAR(13) + CHAR(13)
		SET @Msg = @Msg + 'Please follow this link for visit details: '
		SET @Msg = @Msg + CHAR(13)
		SET @Msg = @Msg + 'http://nhjax-webapps/clinicalportal/EDPTSDetail.aspx?PeId=' + CAST(@pe AS varchar(20))

--		SET @Msg = @Msg + CHAR(13) + CHAR(13)
--		SET @Msg = @Msg + 'Patient:'+ CHAR(9) + CHAR(9) + CHAR(9)+ CHAR(9)
--		SET @Msg = @Msg + @pat
--
--		SET @Msg = @Msg + CHAR(13)
--		SET @Msg = @Msg + 'Last Four SSN:'+ CHAR(9) + CHAR(9) + CHAR(9)
--		SET @Msg = @Msg + @l4
--
--		SET @Msg = @Msg + CHAR(13)
--		SET @Msg = @Msg + 'Phone:'+ CHAR(9) + CHAR(9) + CHAR(9)+ CHAR(9)
--		SET @Msg = @Msg + @phone
--
--		SET @Msg = @Msg + CHAR(13)
--		SET @Msg = @Msg + 'Date/Time:'+ CHAR(9) + CHAR(9) + CHAR(9)+ CHAR(9)
--		SET @Msg = @Msg + CAST(@dt AS Varchar(25))
--
--		SET @Msg = @Msg + CHAR(13)
--		SET @Msg = @Msg + 'Status:'+ CHAR(9) + CHAR(9) + CHAR(9)+ CHAR(9)
--		SET @Msg = @Msg + @stat
--
--		SET @Msg = @Msg + CHAR(13)
--		SET @Msg = @Msg + 'Provider Seen:'+ CHAR(9) + CHAR(9) + CHAR(9)
--		SET @Msg = @Msg + @pro
--
--		SET @Msg = @Msg + CHAR(13)
--		SET @Msg = @Msg + 'Priority:'+ CHAR(9) + CHAR(9) + CHAR(9)+ CHAR(9)
--		SET @Msg = @Msg + @pri
--
--		SET @Msg = @Msg + CHAR(13)
--		SET @Msg = @Msg + 'Arrival Category:'+ CHAR(9) + CHAR(9) + CHAR(9)
--		SET @Msg = @Msg + @ac
		
		SET @Msg = @Msg + CHAR(13) + CHAR(13)
		SET @Msg = @Msg + 'Please review this information for accuracy.  '
		SET @Msg = @Msg + 'If you find any errors in this alert, '
		SET @Msg = @Msg + 'please contact IRMD at 542-7577 '
		SET @Msg = @Msg + 'or put in a Help Desk Ticket at: ' + CHAR(13) + CHAR(13)
		SET @Msg = @Msg + 'http://nhjax-dotnet/enet/default.aspx'

		SET @Msg = @Msg + CHAR(13) + CHAR(13)
		SET @Msg = @Msg + 'This electronic mail and any attachments may '
		SET @Msg = @Msg + 'contain information that is subject to the '
		SET @Msg = @Msg + 'Privacy Act of 1974 and the Health Insurance '
		SET @Msg = @Msg + 'Portability and Accountability Act (HIPAA) of 1996. '
		SET @Msg = @Msg + 'Use and disclosure of protected health '
		SET @Msg = @Msg + 'information is for OFFICIAL USE ONLY, '
		SET @Msg = @Msg + 'and must be in compliance with these statutes. '
		SET @Msg = @Msg + 'If you have inadvertently received this e-mail, '
		SET @Msg = @Msg + 'please notify the sender and delete the data '
		SET @Msg = @Msg + 'without forwarding it or making any copies.'

		--TESTING ONLY - Display PCM EMail
		SET @Msg = @Msg + CHAR(13) + CHAR(13)
		SET @Msg = @Msg + '****TEST DATA****' + CHAR(13)
		SET @Msg = @Msg + 'PCM EMail:' + CHAR(9) + CHAR(9) + CHAR(9)+ CHAR(9)
		SET @Msg = @Msg + @pcmMail

		SET @Msg = @Msg + CHAR(13)
		SET @Msg = @Msg + 'PE:' + CHAR(9) + CHAR(9) + CHAR(9)+ CHAR(9) + CHAR(9)
		SET @Msg = @Msg + CAST(@pe AS Varchar(20))

		SET @Msg = @Msg + CHAR(13)
		SET @Msg = @Msg + 'PatientId:' + CHAR(9) + CHAR(9) + CHAR(9)+ CHAR(9)
		SET @Msg = @Msg + CAST(@pid AS Varchar(14))

		SET @Msg = @Msg + CHAR(13)
		SET @Msg = @Msg + 'FlagId:' + CHAR(9) + CHAR(9) + CHAR(9)+ CHAR(9)
		SET @Msg = @Msg + CAST(@flag AS Varchar(14))
		--END TEST		
		PRINT @pcmMail
		--If @pcmMail = ''
			BEGIN
				SET @pcmMail = 'sean.kern.ctr@med.navy.mil'
			END

		PRINT @flag

		IF @flag > 0
			BEGIN
				EXEC dbo.upSendMail @sub, @msg, @pcmMail
			END
	END
END





GO
DISABLE TRIGGER [dbo].[EDPTS_Patient_Notification_TEST]
    ON [dbo].[PATIENT_ENCOUNTER];


GO
CREATE TRIGGER [dbo].[EDPTS_Patient_Notification] ON [dbo].[PATIENT_ENCOUNTER]
WITH EXEC AS CALLER
AFTER INSERT
AS
DECLARE @loc bigint
DECLARE @pe bigint
DECLARE @msg varchar(1500)
DECLARE @sub varchar(100)
DECLARE @src bigint 
DECLARE @nosend bit
DECLARE @ext int

BEGIN
	--**************************************************************
	--******    CHANGE LOG                                     *****
	----------------------------------------------------------------
	--* 8-10-2011 REE Added Try Catch Block to catch any errors
	--* for debugging.
	--* 3-10-2015 REE Added FOUO to message
	--**************************************************************
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--**************************************************************
	--******    B E G I N   T R Y  C A T C H                   *****
	--**************************************************************
	BEGIN TRY	
			SELECT @loc = HospitalLocationId, 
				@pe = PatientEncounterId, 
				@src = SourceSystemId 
			FROM inserted

			--SET @loc = 174
			--SET @pe = 2702356
		--Set default admin email send to no
		SET @nosend = 0
		SET @ext = 0
		--***************************************************************
		--******** TEST TO ENSURE TRIGGER IS FIRING *********************		
		--EXEC dbo.upActivityLog 'Patient Encounter Record Inserted',5
		--****************************************************************
		--****************************************************************
		--DEBUG STUFF
		UPDATE [NHJAX_ODS].[dbo].[PATIENT_ENCOUNTER] SET [ArrivalCategoryId] = 0
		WHERE [ArrivalCategoryId] < 0 AND [PatientEncounterId] = @pe

		UPDATE [NHJAX_ODS].[dbo].[PATIENT_ENCOUNTER] SET [ReasonSeenId] = 0
		WHERE [ReasonSeenId] IS NULL AND [PatientEncounterId] = @pe

		------------------------------------------------------------------
		--DECLARE @DEBUG_MSG nvarchar(4000)
		--SET @DEBUG_MSG = 'PATIENT_ENCOUNTER TRIGGER FIRED'
		--Send Mail if ER visit from CHCS/EDPTS
		If @loc = 174 AND (@src < 7 OR @src IS NULL OR @src=9 OR @src=14)
			BEGIN
			EXEC dbo.upActivityLog 'ER Record Inserted',5
			--EXEC dbo.upActivityLog 'ER Record Inserted: PatientEncounterId',@pe
			
				--Gather Data about ER Visit
				DECLARE @pcmMail varchar(200)
				DECLARE @pat varchar(32)
				DECLARE @phone varchar(15)
				DECLARE @l4 varchar(4)
				DECLARE @dt datetime
				DECLARE @pro varchar(30)
				DECLARE @stat varchar(30)
				DECLARE @pri varchar(30)
				DECLARE @ac varchar(30)
				DECLARE @pid bigint
				DECLARE @flag int
				DECLARE @usr int
				DECLARE @rea varchar(50)

				--Set default for pcmMail
				SET @pcmMail = 'nopcm'
				SET @flag = 0
				SELECT TOP 1
					@pid = PAT.PatientId, 
					@pat = PAT.FullName, 
					@phone = ISNULL(PAT.Phone,'--'),
					@l4 = ISNULL(RIGHT(PAT.SSN, 4), 'UNK'),
					@dt = ENC.AppointmentDateTime,  
					@pro = PRO.ProviderName,
					@stat = STAT.AppointmentStatusDesc,  
					@pri = PRI.PriorityDesc, 
					@ac = AC.ArrivalCategoryDesc,
					@flag = ISNULL(PFLAG.FlagId,0),
					@rea = REA.ReasonSeenDesc                      
				FROM  PATIENT_ENCOUNTER AS ENC 
					INNER JOIN PATIENT AS PAT 
					ON ENC.PatientId = PAT.PatientId 
					INNER JOIN APPOINTMENT_STATUS AS STAT 
					ON ENC.AppointmentStatusId = STAT.AppointmentStatusId 
					INNER JOIN PROVIDER AS PRO 
					ON ENC.ProviderId = PRO.ProviderId 
					INNER JOIN PRIORITY AS PRI 
					ON ENC.PriorityId = PRI.PriorityId 
					INNER JOIN ARRIVAL_CATEGORY AS AC 
					ON ENC.ArrivalCategoryId = AC.ArrivalCategoryId
					LEFT OUTER JOIN PATIENT_FLAG AS PFLAG
					ON PAT.PatientId = PFLAG.PatientId
					INNER JOIN REASON_SEEN AS REA 
					ON ENC.ReasonSeenId = REA.ReasonSeenId 
				WHERE (ENC.PatientEncounterId = @pe)
				AND PFLAG.FlagId IN (1,2,17)

				EXEC dbo.upActivityLog 'ER Record Inserted: PatientEncounterFlagId',@flag
				
				-- Get EMail Address for PCM
				SELECT @pcmMail = ISNULL(TECH.EMailAddress, 'kristopher.s.kern.ctr@mail.mil'),
				@usr = TECH.UserId
				FROM	PROVIDER AS PRO 
				INNER JOIN PRIMARY_CARE_MANAGER AS PCM 
				ON PRO.ProviderId = PCM.ProviderId 
				LEFT OUTER JOIN vwENET_TECHNICIAN AS TECH 
				ON PRO.ProviderSSN = TECH.SSN
				WHERE PCM.PatientId = @pid
				AND PRO.ProviderId NOT IN 
				(
					SELECT PCMExceptionId 
					FROM PCM_EXCEPTION
				)

				--If @pcmMail is still 'nopcm' then change subject
				IF @pcmMail = 'nopcm'
					BEGIN
						SET @Sub = '***FOUO*** NOPCM Notification for ' + @pat + ' on ' + CAST(getdate() AS varchar(50))
						SET @pcmMail = 'kristopher.s.kern.ctr@mail.mil'	
						SET @nosend = 1 --Disable nopcm email		
					END
				ELSE
					BEGIN
						--Check Deploy Status and alter if deployed: Future alternate use
						SELECT @ext = UserId 
						FROM vwENET_TECHNICIAN_EXTENDED
						WHERE UserId = @usr
						AND Deployed = 1
						AND ReturnDate < getdate() 
						IF @ext > 0
							BEGIN
								SET @Sub = '***FOUO*** Deployed Provider Notification for ' + @pat + ' on ' + CAST(getdate() AS varchar(50))
								SET @pcmMail = 'kristopher.s.kern.ctr@mail.mil'
								SET @nosend = 2
							END
						ELSE
							BEGIN				
								SET @nosend = 1
								SET @Sub = '***FOUO*** At Risk ER Visit Notification'
							END
						--SET @DEBUG_MSG = 'PATIENT_ENCOUNTER TRIGGER pcmMail = nopcm '

						--EXEC dbo.upActivityLog @DEBUG_MSG ,@ext
					END

				IF @flag > 0
						BEGIN
							SET @Msg = 'An At Risk patient has been seen in the ER and is enrolled to your panel:'
							--SET @Msg = @Msg + CAST(@pe AS varchar(50))
							
							EXEC dbo.upActivityLog 'At Risk Seen',5
						END
		--		ELSE IF @flag = 2 
		--				BEGIN
		--				SET @Msg = 'The Diabetic Patient cited below has been seen in the ER and is enrolled to your panel:'
		--				END
				--Add Type
				
				SET @Msg = @Msg + CHAR(13) + CHAR(13)
				
				IF @flag = 1
					BEGIN
						SET @Msg = @Msg + 'Alert Type: Asthma'
					END
					
				IF @flag = 2
					BEGIN
						SET @Msg = @Msg + 'Alert Type: Diabetes'
					END
					
				IF @flag = 17
					BEGIN
						SET @Msg = @Msg + 'Alert Type: Maternity'
					END
					
				SET @Msg = @Msg + CHAR(13)
				SET @Msg = @Msg + 'Reason Seen: ' + @rea

				SET @Msg = @Msg + CHAR(13) + CHAR(13)
				SET @Msg = @Msg + 'Please follow this link for visit details: '
				SET @Msg = @Msg + CHAR(13)
				SET @Msg = @Msg + 'https://nhjax-webapps-01/clinicalportal2/NotificationDetail.aspx?PeId=' + CAST(@pe AS varchar(20))


		--		SET @Msg = @Msg + CHAR(13) + CHAR(13)
		--		SET @Msg = @Msg + 'Patient:'+ CHAR(9) + CHAR(9) + CHAR(9)+ CHAR(9)
		--		SET @Msg = @Msg + @pat
		--
		--		SET @Msg = @Msg + CHAR(13)
		--		SET @Msg = @Msg + 'Last Four SSN:'+ CHAR(9) + CHAR(9) + CHAR(9)
		--		SET @Msg = @Msg + @l4
		--
		--		SET @Msg = @Msg + CHAR(13)
		--		SET @Msg = @Msg + 'Phone:'+ CHAR(9) + CHAR(9) + CHAR(9)+ CHAR(9)
		--		SET @Msg = @Msg + @phone
		--
		--		SET @Msg = @Msg + CHAR(13)
		--		SET @Msg = @Msg + 'Date/Time:'+ CHAR(9) + CHAR(9) + CHAR(9)+ CHAR(9)
		--		SET @Msg = @Msg + CAST(@dt AS Varchar(25))
		--
		--		SET @Msg = @Msg + CHAR(13)
		--		SET @Msg = @Msg + 'Status:'+ CHAR(9) + CHAR(9) + CHAR(9)+ CHAR(9)
		--		SET @Msg = @Msg + @stat
		--
		--		SET @Msg = @Msg + CHAR(13)
		--		SET @Msg = @Msg + 'Provider Seen:'+ CHAR(9) + CHAR(9) + CHAR(9)
		--		SET @Msg = @Msg + @pro
		--
		--		SET @Msg = @Msg + CHAR(13)
		--		SET @Msg = @Msg + 'Priority:'+ CHAR(9) + CHAR(9) + CHAR(9)+ CHAR(9)
		--		SET @Msg = @Msg + @pri
		--
		--		SET @Msg = @Msg + CHAR(13)
		--		SET @Msg = @Msg + 'Arrival Category:'+ CHAR(9) + CHAR(9) + CHAR(9)
		--		SET @Msg = @Msg + @ac
				
				SET @Msg = @Msg + CHAR(13) + CHAR(13)
				SET @Msg = @Msg + 'Please review this information for accuracy.  '
				SET @Msg = @Msg + 'If you find any errors in this alert, '
				SET @Msg = @Msg + 'please contact MID at 542-7577 '
				SET @Msg = @Msg + 'or put in a Help Desk Ticket at: ' + CHAR(13) + CHAR(13)
				SET @Msg = @Msg + 'https://nhjax-webapps-01/enet/default.aspx'

				SET @Msg = @Msg + CHAR(13) + CHAR(13)
				SET @Msg = @Msg + 'This electronic mail and any attachments may '
				SET @Msg = @Msg + 'contain information that is subject to the '
				SET @Msg = @Msg + 'Privacy Act of 1974 and the Health Insurance '
				SET @Msg = @Msg + 'Portability and Accountability Act (HIPAA) of 1996. '
				SET @Msg = @Msg + 'Use and disclosure of protected health '
				SET @Msg = @Msg + 'information is for OFFICIAL USE ONLY, '
				SET @Msg = @Msg + 'and must be in compliance with these statutes. '
				SET @Msg = @Msg + 'If you have inadvertently received this e-mail, '
				SET @Msg = @Msg + 'please notify the sender and delete the data '
				SET @Msg = @Msg + 'without forwarding it or making any copies.'

				--TESTING ONLY - Display PCM EMail
				SET @Msg = @Msg + CHAR(13) + CHAR(13)
				SET @Msg = @Msg + '****OFFICE USE****' + CHAR(13)
				SET @Msg = @Msg + 'PCM EMail:' + CHAR(9) + CHAR(9) + CHAR(9)+ CHAR(9)
				SET @Msg = @Msg + @pcmMail

				SET @Msg = @Msg + CHAR(13)
				SET @Msg = @Msg + 'PE:' + CHAR(9) + CHAR(9) + CHAR(9)+ CHAR(9) + CHAR(9)
				SET @Msg = @Msg + CAST(@pe AS Varchar(20))

				SET @Msg = @Msg + CHAR(13)
				SET @Msg = @Msg + 'PatientId:' + CHAR(9) + CHAR(9) + CHAR(9)+ CHAR(9)
				SET @Msg = @Msg + CAST(@pid AS Varchar(14))

				SET @Msg = @Msg + CHAR(13)
				SET @Msg = @Msg + 'FlagId:' + CHAR(9) + CHAR(9) + CHAR(9)+ CHAR(9)
				SET @Msg = @Msg + CAST(@flag AS Varchar(14))
				--END TEST		

				If @pcmMail = ''
					BEGIN
						SET @pcmMail = 'kristopher.s.kern.ctr@mail.mil'
					END

				--PRINT @flag

				IF @flag > 0 AND @nosend > 0
					BEGIN
						EXEC dbo.upActivityLog 'Send At Risk Mail',5
						EXEC dbo.upSendMail @sub, @msg, @pcmMail
					END
			END
	END TRY
	BEGIN CATCH
		EXECUTE usp_GetErrorInfo;
	END CATCH
	--**************************************************************
	--******    E N D   T R Y  C A T C H                       *****
	--**************************************************************

END
GO
-- =============================================
-- Author:		K. Sean Kern
-- Create date: 2010-05-12
-- Description:	Updates Encounter Provider 
-- =============================================
CREATE TRIGGER [dbo].[trODS_PATIENT_ENCOUNTER_UpdateProvider] ON [dbo].[PATIENT_ENCOUNTER]
FOR INSERT,UPDATE
AS


DECLARE @enc bigint
DECLARE @pro bigint
DECLARE @pcm bigint
DECLARE @pat bigint

DECLARE @encX bigint
DECLARE @proX bigint

Declare @exists int

IF UPDATE(PatientEncounterId) OR UPDATE(ProviderId)
BEGIN
	
	SELECT 
		@enc = PatientEncounterId,
		@pro = ISNULL(ProviderId,0),
		@pat = PatientId
	FROM inserted 
	
	IF @pro > 0
	BEGIN
	
		SELECT @proX = ProviderId,
			@encX = PatientEncounterId
		FROM ENCOUNTER_PROVIDER
		WHERE ProviderId = @pro
			AND PatientEncounterId = @enc
			AND ProviderRoleId = 9
		SET @exists = @@RowCount
		If @exists = 0
			BEGIN
				INSERT INTO ENCOUNTER_PROVIDER
				(
					PatientEncounterId,
					ProviderId,
					ProviderRoleId
				)
				VALUES
				(
					@enc,
					@pro,
					9
				)
			END	
		END
		
		--Timestamp PCM at time of Encounter
		SELECT @pcm = ISNULL(ProviderId,0)
		FROM PRIMARY_CARE_MANAGER
		WHERE PatientId = @pat
		
		IF @pcm > 0
		BEGIN
			SELECT @proX = ProviderId,
			@encX = PatientEncounterId
		FROM ENCOUNTER_PROVIDER
		WHERE ProviderId = @pcm
			AND PatientEncounterId = @enc
			AND ProviderRoleId = 12
		SET @exists = @@RowCount
		If @exists = 0
			BEGIN
				INSERT INTO ENCOUNTER_PROVIDER
				(
					PatientEncounterId,
					ProviderId,
					ProviderRoleId
				)
				VALUES
				(
					@enc,
					@pcm,
					12
				)
			END	
		END
					
		--DECLARE @test varchar(50)
		--SET @test = @pfx + @strNum + @ext
		--EXEC dbo.procFORM_Activity_Log @pfx
		--EXEC dbo.procFORM_Activity_Log @strNum
		--EXEC dbo.procFORM_Activity_Log @ext
		--EXEC dbo.procFORM_Activity_Log @test


END
