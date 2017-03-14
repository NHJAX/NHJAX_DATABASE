-- =============================================
-- Author:		Robert Evans
-- Create date: June 9 2015
-- Description:	To be run daily to get the access to care data.
-- =============================================
CREATE PROCEDURE procCP_GET_DAILY_ACCESS_TO_CARE_DATA
AS
BEGIN
SET NOCOUNT ON;

DECLARE @FromDate date=GETDATE()
DECLARE @ToDate date=DateAdd(d,45,@FromDate)
--CURSOR VARIABLES
DECLARE @LocationName NVARCHAR(20)
DECLARE @ClinicName NVARCHAR(36)
DECLARE @ProviderId bigint
DECLARE @ProviderName NVARCHAR(40)
DECLARE @AppointmentDate Date
DECLARE @AppointmentMonth int
DECLARE @AppointmentDay int
DECLARE @AppointmentYear int
DECLARE @AppointmentHour int
DECLARE @AppointmentMinute int
DECLARE @AppointmentDateTime datetime
DECLARE @AppointmentDescription nvarchar(30)
DECLARE @AppointmentSlotStatusId bigint
DECLARE @AppointmentTypeId bigint
DECLARE @AppointmentType nvarchar(30)
DECLARE @LocationId bigint
--*********************************************************
--COMPUTED VARIABLES
DECLARE @830ThisMorning datetime
DECLARE @TodaysDate date = getdate()
DECLARE @todayString NVARCHAR(25) = CONVERT(NVARCHAR(10),@TodaysDate)

DECLARE @TotalOpen int = 0
DECLARE @TotalBooked int = 0
DECLARE @TotalFrozen int = 0
DECLARE @TotalCancelled int = 0
DECLARE @TotalWait int = 0
DECLARE @TotalLocked int = 0

DECLARE @AcutAvailApptCount int = 0
DECLARE @RoutAvailApptCount int = 0
DECLARE @SpecAvailApptCount int = 0
DECLARE @WellAvailApptCount int = 0
DECLARE @TNAA_Acut datetime = NULL
DECLARE @TNAA_Rout datetime = NULL
DECLARE @TNAA_Spec datetime = NULL
DECLARE @TNAA_Well datetime = NULL

--*********************************************************
--HOLD VARIABLES
DECLARE @HoldProviderID bigint = 0
DECLARE @HoldLocationID bigint = 0
DECLARE @HoldApptDateTime datetime
DECLARE @HoldDate date
DECLARE @HoldDate830 datetime

DECLARE @HoldDateString nvarchar(25) = ''
--*********************************************************
--*********************************************************
DECLARE @ProviderData TABLE (ProviderId bigint NOT NULL,
							 LocationId bigint NULL,
							 TotalOpen int NULL,
							 TotalFrozen int NULL,
							 TotalCancelled int NULL,
							 TotalBooked int NULL,
							 TotalWait int NULL,
							 TotalLocked int NULL,
							 ThirdNextAvailAcut datetime NULL,
							 DaysAcut numeric(5,2) NULL,
							 DDAcut int NULL,
							 ThirdNextAvailRout datetime NULL,
							 DaysRout numeric(5,2) NULL,
							 DDRout int NULL,
							 ThirdNextAvailSpec datetime NULL,
							 DaysSpec numeric(5,2) NULL,
							 DDSpec int NULL,
							 ThirdNextAvailWell datetime NULL,
							 DaysWell numeric(5,2) NULL,
							 DDWell int NULL,
							 LastAppointment datetime NULL,
							 ApptDate date NULL)

DECLARE @ReportData TABLE (LocationName NVARCHAR(20) NULL,
 ClinicName NVARCHAR(36) NULL,
 LocationId bigint NULL,
 ProviderId bigint NULL,
 ProviderName NVARCHAR(40) NULL,
 AppointmentDate Date NULL,
 AppointmentMonth int NULL,
 AppointmentDay int NULL,
 AppointmentYear int NULL,
 AppointmentHour int NULL,
 AppointmentMinute int NULL,
 AppointmentDateTime datetime NULL,
 AppointmentDescription nvarchar(30) NULL,
 AppointmentType nvarchar(30) NULL)
 
SET @830ThisMorning = CONVERT(datetime, @todayString + 'T08:30:00.000')

DECLARE curAppointments CURSOR LOCAL FOR
SELECT DISTINCT CASE MC.[DmisId]
			WHEN 1527 THEN 'NH Jacksonville'
			WHEN 1659 THEN 'NBHC Jacksonville'
			WHEN 1740 THEN 'NBHC Mayport'
			WHEN 1811 THEN 'NBHC Key West'
			WHEN 1664 THEN 'NBHC Albany'
			WHEN 1698 THEN 'NBHC Kings Bay'
		 ELSE 'Unknown'
	   END as HospitalOrClinic
	  ,HL.[HospitalLocationName]
	  ,PRO.[ProviderId]
	  ,PRO.[ProviderName]
	  ,CAST(ASL.[AppointmentSlotDateTime] AS Date) as ApptDate
	  ,DATEPART(m,ASL.[AppointmentSlotDateTime]) as ApptMonth
	  ,DATEPART(d,ASL.[AppointmentSlotDateTime]) as ApptDay
	  ,DATEPART(yy,ASL.[AppointmentSlotDateTime]) as ApptYear
	  ,DATEPART(hh,ASL.[AppointmentSlotDateTime]) as ApptHour
	  ,DATEPART(n,ASL.[AppointmentSlotDateTime]) as ApptMinute
	  ,ASL.[AppointmentSlotDateTime] as ApptDateTime
	  ,ASS.[AppointmentSlotStatusDesc]
	  ,ATY.[AppointmentTypeDesc]
	  ,ASS.[AppointmentSlotStatusId]
	  ,ATY.[AppointmentTypeId]
	  ,HL.[HospitalLocationId]
FROM [NHJAX_ODS].[dbo].[APPOINTMENT_SLOT] AS ASL
	INNER JOIN [NHJAX_ODS].[dbo].[APPOINTMENT_TYPE] AS ATY  
		ON ATY.[AppointmentTypeId] = ASL.[AppointmentTypeId]
	INNER JOIN [NHJAX_ODS].[dbo].[APPOINTMENT_SLOT_STATUS] AS ASS  
		ON ASS.[AppointmentSlotStatusId] = ASL.[AppointmentSlotStatusId]
	INNER JOIN [NHJAX_ODS].dbo.[HOSPITAL_LOCATION] as HL 
		ON HL.HospitalLocationId = ASL.HospitalLocationId
	INNER JOIN [NHJAX_ODS].dbo.[MEPRS_CODE] as MC 
		ON MC.[MeprsCodeId] = HL.[MeprsCodeId] AND MC.[DmisId] IN (1527,1659,1740,1811,1664,1698)
	INNER JOIN [NHJAX_ODS].dbo.[PROVIDER] as PRO
		ON ASL.[ProviderId] = PRO.[ProviderId]
WHERE CONVERT(Date,ASL.[AppointmentSlotDateTime]) >= 
							CASE 
								WHEN @830ThisMorning is null 
								THEN CONVERT(Date,ASL.[AppointmentSlotDateTime]) 
								ELSE Dateadd(d,-1,@830ThisMorning) 
							END
--AND CONVERT(Date,ASL.[AppointmentSlotDateTime]) <= 
--							CASE 
--								WHEN @ToDate is null 
--								THEN CONVERT(Date,ASL.[AppointmentSlotDateTime]) 
--								ELSE @ToDate 
--							END
ORDER BY	HospitalOrClinic 
			,HL.[HospitalLocationId]
			,PRO.[ProviderId]
			,ASL.[AppointmentSlotDateTime] 
			,ASS.[AppointmentSlotStatusDesc] DESC

OPEN curAppointments

FETCH NEXT FROM curAppointments INTO @LocationName, @ClinicName, @ProviderId, @ProviderName, @AppointmentDate, @AppointmentMonth, @AppointmentDay, @AppointmentYear, 
@AppointmentHour, @AppointmentMinute, @AppointmentDateTime, @AppointmentDescription, @AppointmentType, @AppointmentSlotStatusId, @AppointmentTypeId, @LocationId

SET @HoldProviderID = @ProviderId
SET @HoldLocationID = @LocationId
SET @HoldDate = @AppointmentDate 
WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @HoldProviderID = @ProviderId  --PROVIDER DIDNT CHANGE
			BEGIN
				IF @HoldDate <> @AppointmentDate
					BEGIN
						INSERT INTO @ProviderData (ProviderId, 
						LocationId, 
						TotalOpen, 
						TotalFrozen, 
						TotalCancelled, 
						TotalBooked, 
						TotalWait, 
						TotalLocked, 
						ThirdNextAvailAcut, 
						DaysAcut, 
						DDAcut, 
						ThirdNextAvailRout, 
						DaysRout, 
						DDRout, 
						ThirdNextAvailSpec, 
						DaysSpec, 
						DDSpec, 
						ThirdNextAvailWell, 
						DaysWell, 
						DDWell, 
						LastAppointment,
						ApptDate)
						VALUES(@HoldProviderID, 
						@HoldLocationID, 
						@TotalOpen, 
						@TotalFrozen, 
						@TotalCancelled, 
						@TotalBooked, 
						@TotalWait, 
						@TotalLocked,
						@TNAA_Acut, 
						DATEDIFF(hh,@HoldDate830,@TNAA_Acut),
						CAST(CAST(DATEDIFF(hh,@HoldDate830,@TNAA_Acut) as NUMERIC(5,2))/24.0 as NUMERIC(5,2)),
						@TNAA_Rout, 
						DATEDIFF(hh,@HoldDate830,@TNAA_Rout),
						CAST(CAST(DATEDIFF(hh,@HoldDate830,@TNAA_Rout) as NUMERIC(5,2))/24.0 as NUMERIC(5,2)),
						@TNAA_Spec,
						DATEDIFF(hh,@HoldDate830,@TNAA_Spec),
						CAST(CAST(DATEDIFF(hh,@HoldDate830,@TNAA_Spec) as NUMERIC(5,2))/24.0 as NUMERIC(5,2)),
						@TNAA_Well,
						DATEDIFF(hh,@HoldDate830,@TNAA_Well),
						CAST(CAST(DATEDIFF(hh,@HoldDate830,@TNAA_Well) as NUMERIC(5,2))/24.0 as NUMERIC(5,2)),
						@HoldApptDateTime,
						@HoldDate)
						SET @TotalOpen = 0
						SET @TotalFrozen = 0
						SET @TotalCancelled = 0
						SET @TotalBooked = 0
						SET @TotalWait = 0
						SET @TotalLocked = 0
						SET @AcutAvailApptCount = 0
						SET @RoutAvailApptCount = 0
						SET @SpecAvailApptCount = 0
						SET @WellAvailApptCount = 0
						SET @TNAA_Acut = NULL
						SET @TNAA_Rout = NULL
						SET @TNAA_Spec = NULL
						SET @TNAA_Well = NULL
						SET @HoldDate = @AppointmentDate
						SET @HoldDateString = CONVERT(NVARCHAR(10),@HoldDate) + 'T08:30:00.000'

						SET @HoldDate830 = CONVERT(datetime, @HoldDateString)
					END
				--ADD TO SLOT STATUS COUNTERS
				IF @AppointmentSlotStatusId = 1 SET @TotalOpen = @TotalOpen + 1
				IF @AppointmentSlotStatusId = 2 SET @TotalFrozen = @TotalFrozen + 1
				IF @AppointmentSlotStatusId = 3 SET @TotalCancelled = @TotalCancelled + 1
				IF @AppointmentSlotStatusId = 4 SET @TotalBooked = @TotalBooked + 1
				IF @AppointmentSlotStatusId = 5 SET @TotalWait = @TotalWait + 1
				IF @AppointmentSlotStatusId = 6 SET @TotalLocked = @TotalLocked + 1
				--Find the Third Next Avail AppointDate
				IF @AcutAvailApptCount < 3 AND @AppointmentSlotStatusId = 1 AND @AppointmentTypeId = 224 --ACUTE APPT
					BEGIN
						IF @AcutAvailApptCount = 2
							BEGIN
								SET @TNAA_Acut = @AppointmentDateTime
							END
						SET @AcutAvailApptCount = @AcutAvailApptCount + 1
					END
				IF @RoutAvailApptCount < 3 AND @AppointmentSlotStatusId = 1 AND @AppointmentTypeId = 551 --ROUTINE ESTABLISHED APPT
					BEGIN
						IF @RoutAvailApptCount = 2
							BEGIN
								SET @TNAA_Rout = @AppointmentDateTime
							END
						SET @RoutAvailApptCount = @RoutAvailApptCount + 1
					END
				IF @SpecAvailApptCount < 3 AND @AppointmentSlotStatusId = 1 AND @AppointmentTypeId = 1288 --Specialty APPT
					BEGIN
						IF @SpecAvailApptCount = 2
							BEGIN
								SET @TNAA_Spec = @AppointmentDateTime
							END
						SET @SpecAvailApptCount = @SpecAvailApptCount + 1
					END
				IF @WellAvailApptCount < 3 AND @AppointmentSlotStatusId = 1 AND @AppointmentTypeId = 1459 --Wellness APPT
					BEGIN
						IF @WellAvailApptCount = 2
							BEGIN
								SET @TNAA_Well = @AppointmentDateTime
							END
						SET @WellAvailApptCount = @WellAvailApptCount + 1
					END
				SET @HoldApptDateTime = @AppointmentDateTime
			END
		ELSE
			BEGIN
				INSERT INTO @ProviderData (ProviderId, 
				LocationId, 
				TotalOpen, 
				TotalFrozen, 
				TotalCancelled, 
				TotalBooked, 
				TotalWait, 
				TotalLocked, 
				ThirdNextAvailAcut, 
				DaysAcut, 
				DDAcut, 
				ThirdNextAvailRout, 
				DaysRout, 
				DDRout, 
				ThirdNextAvailSpec, 
				DaysSpec, 
				DDSpec, 
				ThirdNextAvailWell, 
				DaysWell, 
				DDWell, 
				LastAppointment,
				ApptDate)
				VALUES(@HoldProviderID, 
				@HoldLocationID, 
				@TotalOpen, 
				@TotalFrozen, 
				@TotalCancelled, 
				@TotalBooked, 
				@TotalWait, 
				@TotalLocked,
				@TNAA_Acut, 
				DATEDIFF(hh,@HoldDate830,@TNAA_Acut),
				CAST(CAST(DATEDIFF(hh,@HoldDate830,@TNAA_Acut) as NUMERIC(5,2))/24.0 as NUMERIC(5,2)),
				@TNAA_Rout, 
				DATEDIFF(hh,@HoldDate830,@TNAA_Rout),
				CAST(CAST(DATEDIFF(hh,@HoldDate830,@TNAA_Rout) as NUMERIC(5,2))/24.0 as NUMERIC(5,2)),
				@TNAA_Spec,
				DATEDIFF(hh,@HoldDate830,@TNAA_Spec),
				CAST(CAST(DATEDIFF(hh,@HoldDate830,@TNAA_Spec) as NUMERIC(5,2))/24.0 as NUMERIC(5,2)),
				@TNAA_Well,
				DATEDIFF(hh,@HoldDate830,@TNAA_Well),
				CAST(CAST(DATEDIFF(hh,@HoldDate830,@TNAA_Well) as NUMERIC(5,2))/24.0 as NUMERIC(5,2)),
				@HoldApptDateTime,
				@HoldDate)

				UPDATE @ProviderData SET LastAppointment = @HoldApptDateTime WHERE ProviderId = @HoldProviderID

				SET @TotalOpen = 0
				SET @TotalFrozen = 0
				SET @TotalCancelled = 0
				SET @TotalBooked = 0
				SET @TotalWait = 0
				SET @TotalLocked = 0
				SET @AcutAvailApptCount = 0
				SET @RoutAvailApptCount = 0
				SET @SpecAvailApptCount = 0
				SET @WellAvailApptCount = 0
				SET @TNAA_Acut = NULL
				SET @TNAA_Rout = NULL
				SET @TNAA_Spec = NULL
				SET @TNAA_Well = NULL
				SET @HoldProviderID = @ProviderId
				SET @HoldLocationID = @LocationId
				--ADD TO SLOT STATUS COUNTERS
				IF @AppointmentSlotStatusId = 1 SET @TotalOpen = @TotalOpen + 1
				IF @AppointmentSlotStatusId = 2 SET @TotalFrozen = @TotalFrozen + 1
				IF @AppointmentSlotStatusId = 3 SET @TotalCancelled = @TotalCancelled + 1
				IF @AppointmentSlotStatusId = 4 SET @TotalBooked = @TotalBooked + 1
				IF @AppointmentSlotStatusId = 5 SET @TotalWait = @TotalWait + 1
				IF @AppointmentSlotStatusId = 6 SET @TotalLocked = @TotalLocked + 1
				--Find the Third Next Avail AppointDate
				IF @AcutAvailApptCount < 3 AND @AppointmentSlotStatusId = 1 AND @AppointmentTypeId = 224 --ACUTE APPT
					BEGIN
						IF @AcutAvailApptCount = 2
							BEGIN
								SET @TNAA_Acut = @AppointmentDateTime
							END
						SET @AcutAvailApptCount = @AcutAvailApptCount + 1
					END
				IF @RoutAvailApptCount < 3 AND @AppointmentSlotStatusId = 1 AND @AppointmentTypeId = 551 --ROUTINE ESTABLISHED APPT
					BEGIN
						IF @RoutAvailApptCount = 2
							BEGIN
								SET @TNAA_Rout = @AppointmentDateTime
							END
						SET @RoutAvailApptCount = @RoutAvailApptCount + 1
					END
				IF @SpecAvailApptCount < 3 AND @AppointmentSlotStatusId = 1 AND @AppointmentTypeId = 1288 --Specialty APPT
					BEGIN
						IF @SpecAvailApptCount = 2
							BEGIN
								SET @TNAA_Spec = @AppointmentDateTime
							END
						SET @SpecAvailApptCount = @SpecAvailApptCount + 1
					END
				IF @WellAvailApptCount < 3 AND @AppointmentSlotStatusId = 1 AND @AppointmentTypeId = 1459 --Wellness APPT
					BEGIN
						IF @WellAvailApptCount = 2
							BEGIN
								SET @TNAA_Well = @AppointmentDateTime
							END
						SET @WellAvailApptCount = @WellAvailApptCount + 1
					END
				SET @HoldApptDateTime = @AppointmentDateTime
			END

		INSERT INTO @ReportData
		SELECT @LocationName, @ClinicName, @LocationId, @ProviderId, @ProviderName, @AppointmentDate, @AppointmentMonth, @AppointmentDay, @AppointmentYear, 
		@AppointmentHour, @AppointmentMinute, @AppointmentDateTime, @AppointmentDescription, @AppointmentType

		FETCH NEXT FROM curAppointments INTO @LocationName, @ClinicName, @ProviderId, @ProviderName, @AppointmentDate, @AppointmentMonth, @AppointmentDay, @AppointmentYear, 
		@AppointmentHour, @AppointmentMinute, @AppointmentDateTime, @AppointmentDescription, @AppointmentType, @AppointmentSlotStatusId, @AppointmentTypeId, @LocationId
	END
CLOSE curAppointments
DEALLOCATE curAppointments

SELECT RD.LocationName as 'HospitalOrClinic'
,RD.ClinicName as 'HospitalLocationName'
,RD.LocationId
,RD.ProviderId
,RD.ProviderName
,RD.AppointmentDateTime
,RD.AppointmentDescription
,CONVERT(date,RD.AppointmentDateTime) as ApptDay
,CONVERT(NVARCHAR(10),CONVERT(date,RD.AppointmentDateTime)) as ApptDayString
,CONVERT(NVARCHAR(5),Convert(time,RD.AppointmentDateTime)) as ApptTime
,RD.AppointmentType
,PD.TotalOpen
,PD.TotalFrozen
,PD.TotalCancelled
,PD.TotalBooked
,PD.TotalWait
,PD.TotalLocked
,PD.ThirdNextAvailAcut
,PD.DDAcut
,PD.ThirdNextAvailRout
,PD.DDRout
,PD.ThirdNextAvailSpec
,PD.DDSpec
,PD.ThirdNextAvailWell
,PD.DDWell
,PD.LastAppointment
,DATEDIFF(d,GETDATE(),PD.LastAppointment) as DaysScheduledForward
,PD.DaysAcut
,PD.DaysRout
,PD.DaysSpec
,PD.DaysWell
FROM @ReportData as RD
	INNER JOIN @ProviderData AS PD ON PD.ProviderId = RD.ProviderId AND PD.LocationId = RD.LocationId AND PD.ApptDate = RD.AppointmentDate
ORDER BY RD.LocationName, RD.LocationId, RD.ProviderName, RD.AppointmentDateTime

END
