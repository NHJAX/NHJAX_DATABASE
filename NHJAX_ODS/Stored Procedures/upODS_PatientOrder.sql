
CREATE PROCEDURE [dbo].[upODS_PatientOrder] AS

Declare @ord decimal
Declare @num varchar(30)
Declare @pat bigint
Declare @inout bigint
Declare @type bigint
Declare @loc bigint
Declare @pro bigint
Declare @sigdate datetime
Declare @date datetime
Declare @appt bigint
Declare @cost numeric(17,5)
Declare @qty numeric(15,5)
Declare @elm numeric(21,3)
Declare @unit money
Declare @ocost money
Declare @coll bigint
Declare @pri bigint
Declare @req bigint
Declare @etd datetime
Declare @nsd datetime
Declare @usr datetime
Declare @port int
Declare @sdt datetime
Declare @txt varchar(240)
Declare @mob int
Declare @imp varchar(4000)
Declare @stat bigint
Declare @ss bigint
Declare @com varchar(1000)

Declare @ordX decimal
Declare @numX varchar(30)
Declare @patX bigint
Declare @inoutX bigint
Declare @typeX bigint
Declare @locX bigint
Declare @proX bigint
Declare @sigdateX datetime
Declare @dateX datetime
Declare @apptX bigint
Declare @costX numeric(17,5)
Declare @qtyX numeric(15,5)
Declare @elmX numeric(21,3)
Declare @unitX money
Declare @ocostX money
Declare @collX bigint
Declare @priX bigint
Declare @reqX bigint
Declare @etdX datetime
Declare @nsdX datetime
Declare @usrX datetime
Declare @portX int
Declare @sdtX datetime
Declare @txtX varchar(240)
Declare @mobX int
Declare @impX varchar(4000)
Declare @statX bigint
Declare @comX varchar(1000)

Declare @urow int
Declare @trow int
Declare @irow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @fromDate datetime
Declare @tempDate datetime
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Orders',0,@day;

SET @tempDate = DATEADD(d,-380,getdate());
SET @fromDate = dbo.StartOfDay(@tempDate); 

DECLARE curOrder CURSOR FAST_FORWARD FOR
SELECT O.KEY_ORDER, 
	O.ID_NUMBER, 
	PAT.PatientId, 
	OE.OrderEncounterTypeId, 
	OT.OrderTypeId, 
	LOC.HospitalLocationId, 
	ISNULL(PRO.ProviderId,0), 
    O.HCP_SIG_DATE_TIME, 
	ISNULL(O.ORDER_DATE_TIME,O.USER_SIG_DATE_TIME) AS OrderDateTime, 
	ENC.PatientEncounterId, 
	O.PDTS_FILL_COST, 
	O.QUANTITY, 
	O.MEDICATION_IEN AS OrderElementKey, 
	ISNULL(DRUG.PDTSUnitCost,0) AS UnitCost,
	CASE ISNULL(O.PDTS_FILL_COST,0)
		WHEN 0
			THEN
				CASE ISNULL(DRUG.PDTSUnitCost,0)
					WHEN 0
						THEN 0
					ELSE
						DRUG.PDTSUnitCost * O.QUANTITY
				END
		ELSE
			O.PDTS_FILL_COST
	END AS OrderCost,
	COLL.CollectionSampleId,
	PRI.OrderPriorityId,
	RPRO.ProviderId,
	O.EARLIEST_TASK_DATE_TIME,
	O.NURSE_SIG_DATE_TIME,
	O.USER_SIG_DATE_TIME,
	ISNULL(PORTABLE.PortableId, 2),
	O.START_DATE_TIME,
	O.DISPLAY_TEXT,
	ISNULL(MOB.MobilityStatusId, 0),
	O.CLINICAL_IMPRESSION,
	STAT.OrderStatusId,
	0 AS SourceSystemId,
	NULL AS OrderComment
FROM   vwMDE_ORDER_ O 
	INNER JOIN PATIENT PAT 
	ON O.PATIENT_IEN = PAT.PatientKey 
	INNER JOIN ORDER_ENCOUNTER_TYPE OE 
	ON O.IN_OUTPATIENT = OE.OrderEncounterTypeDesc 
	INNER JOIN ORDER_TYPE OT 
	ON O.ORDER_TYPE_IEN = OT.OrderTypeKey 
	INNER JOIN HOSPITAL_LOCATION LOC 
	ON O.PATIENT_LOCATION_IEN = LOC.HospitalLocationKey 
	INNER JOIN PROVIDER PRO 
	ON O.ORDERING_HCP_IEN = PRO.ProviderKey 
	LEFT OUTER JOIN DRUG 
	ON O.MEDICATION_IEN = DRUG.DrugKey 
	LEFT OUTER JOIN PATIENT_ENCOUNTER ENC 
	ON O.OUTPATIENT_ENCOUNTER_IEN = ENC.PatientAppointmentKey
	LEFT OUTER JOIN COLLECTION_SAMPLE COLL
	ON O.COLLECTION_SAMPLE_IEN = COLL.CollectionSampleKey
	INNER JOIN ORDER_PRIORITY PRI
	ON O.Priority_IEN = PRI.OrderPriorityKey
	LEFT OUTER JOIN PROVIDER AS RPRO
	ON O.REQUESTING_PHYSICIAN_IEN = RPRO.ProviderKey
	LEFT OUTER JOIN PORTABLE
	ON O.PORTABLE = PORTABLE.PortableDesc
	LEFT OUTER JOIN MOBILITY_STATUS AS MOB
	ON O.MOBILITY_STATUS = MOB.MobilityStatusDesc
	LEFT OUTER JOIN vwMDE_ORDER_TASK_MAX AS TMAX 
	ON O.KEY_ORDER = TMAX.ORDER_IEN 
	LEFT OUTER JOIN vwMDE_ORDER_TASK AS TASK 
	ON TASK.KEY_ORDER_TASK = TMAX.MaxOrderTask
	INNER JOIN ORDER_STATUS AS STAT
	ON ISNULL(TASK.TASK_STATUS,'') = STAT.OrderStatusDesc
WHERE   (OT.OrderTypeId = 16) 
	AND (O.USER_SIG_DATE_TIME >= @fromDate)
UNION
SELECT 	O.KEY_ORDER, 
	O.ID_NUMBER, 
	PAT.PatientId, 
	OE.OrderEncounterTypeId, 
	OT.OrderTypeId, 
	LOC.HospitalLocationId, 
	PRO.ProviderId, 
    O.HCP_SIG_DATE_TIME, 
	ISNULL(O.ORDER_DATE_TIME,O.USER_SIG_DATE_TIME) AS OrderDateTime, 
	ENC.PatientEncounterId, 
	O.PDTS_FILL_COST, 
	O.QUANTITY, 
	O.RADIOLOGY_PROCEDURE_IEN AS OrderElementKey, 
	ISNULL(RAD.UnitCost,0) AS UnitCost,
	ISNULL(RAD.UnitCost,0) AS OrderCost,
	COLL.CollectionSampleId,
	PRI.OrderPriorityId,
	ISNULL(PRO.ProviderId,0),
	O.EARLIEST_TASK_DATE_TIME,
	O.NURSE_SIG_DATE_TIME,
	O.USER_SIG_DATE_TIME,
	ISNULL(PORTABLE.PortableId, 2),
	O.START_DATE_TIME,
	O.DISPLAY_TEXT,
	ISNULL(MOB.MobilityStatusId, 0),
	O.CLINICAL_IMPRESSION,
	STAT.OrderStatusId,
	0 AS SourceSystemId,
	NULL AS OrderComment
FROM   vwMDE_ORDER_ O 
	INNER JOIN PATIENT PAT 
	ON O.PATIENT_IEN = PAT.PatientKey 
	INNER JOIN ORDER_ENCOUNTER_TYPE OE 
	ON O.IN_OUTPATIENT = OE.OrderEncounterTypeDesc 
	INNER JOIN ORDER_TYPE OT 
	ON O.ORDER_TYPE_IEN = OT.OrderTypeKey 
	INNER JOIN HOSPITAL_LOCATION LOC 
	ON O.PATIENT_LOCATION_IEN = LOC.HospitalLocationKey 
	INNER JOIN PROVIDER PRO 
	ON O.ORDERING_HCP_IEN = PRO.ProviderKey 
	LEFT OUTER JOIN RADIOLOGY RAD 
	ON O.RADIOLOGY_PROCEDURE_IEN = RAD.RadiologyKey 
	LEFT OUTER JOIN PATIENT_ENCOUNTER ENC 
	ON O.OUTPATIENT_ENCOUNTER_IEN = ENC.PatientAppointmentKey
	LEFT OUTER JOIN COLLECTION_SAMPLE COLL
	ON O.COLLECTION_SAMPLE_IEN = COLL.CollectionSampleKey
	INNER JOIN ORDER_PRIORITY PRI
	ON O.Priority_IEN = PRI.OrderPriorityKey
	LEFT OUTER JOIN PROVIDER AS RPRO
	ON O.REQUESTING_PHYSICIAN_IEN = RPRO.ProviderKey
	LEFT OUTER JOIN PORTABLE
	ON O.PORTABLE = PORTABLE.PortableDesc
	LEFT OUTER JOIN MOBILITY_STATUS AS MOB
	ON O.MOBILITY_STATUS = MOB.MobilityStatusDesc
	LEFT OUTER JOIN vwMDE_ORDER_TASK_MAX AS TMAX 
	ON O.KEY_ORDER = TMAX.ORDER_IEN 
	LEFT OUTER JOIN vwMDE_ORDER_TASK AS TASK 
	ON TASK.KEY_ORDER_TASK = TMAX.MaxOrderTask
	INNER JOIN ORDER_STATUS AS STAT
	ON ISNULL(TASK.TASK_STATUS,'') = STAT.OrderStatusDesc
WHERE   (OT.OrderTypeId = 15) 
	AND (O.USER_SIG_DATE_TIME >= @fromDate)
UNION
SELECT	O.KEY_ORDER, 
	O.ID_NUMBER, 
	PAT.PatientId, 
	OE.OrderEncounterTypeId, 
	OT.OrderTypeId, 
	LOC.HospitalLocationId, 
	PRO.ProviderId, 
    O.HCP_SIG_DATE_TIME, 
	ISNULL(O.ORDER_DATE_TIME,O.USER_SIG_DATE_TIME) AS OrderDateTime,
	ENC.PatientEncounterId, 
	O.PDTS_FILL_COST, 
	O.QUANTITY, 
	O.LAB_TEST_IEN AS OrderElementKey, 
    ISNULL(LAB.UnitCost, 0) AS UnitCost,
	ISNULL(LAB.UnitCost, 0) AS OrderCost,
	COLL.CollectionSampleId,
	PRI.OrderPriorityId,
	ISNULL(PRO.ProviderId,0),
	O.EARLIEST_TASK_DATE_TIME,
	O.NURSE_SIG_DATE_TIME,
	O.USER_SIG_DATE_TIME,
	ISNULL(PORTABLE.PortableId, 2),
	O.START_DATE_TIME,
	O.DISPLAY_TEXT,
	ISNULL(MOB.MobilityStatusId, 0),
	O.CLINICAL_IMPRESSION,
	STAT.OrderStatusId,
	0 AS SourceSystemId,
	NULL AS OrderComment
FROM   vwMDE_ORDER_ O 
	INNER JOIN PATIENT PAT 
	ON O.PATIENT_IEN = PAT.PatientKey 
	INNER JOIN ORDER_ENCOUNTER_TYPE OE 
	ON O.IN_OUTPATIENT = OE.OrderEncounterTypeDesc 
	INNER JOIN ORDER_TYPE OT 
	ON O.ORDER_TYPE_IEN = OT.OrderTypeKey 
	INNER JOIN HOSPITAL_LOCATION LOC 
	ON O.PATIENT_LOCATION_IEN = LOC.HospitalLocationKey 
	INNER JOIN PROVIDER PRO 
	ON O.ORDERING_HCP_IEN = PRO.ProviderKey 
	LEFT OUTER JOIN LAB_TEST LAB 
	ON O.LAB_TEST_IEN = LAB.LabTestKey 
	LEFT OUTER JOIN PATIENT_ENCOUNTER ENC 
	ON O.OUTPATIENT_ENCOUNTER_IEN = ENC.PatientAppointmentKey
	LEFT OUTER JOIN COLLECTION_SAMPLE COLL
	ON O.COLLECTION_SAMPLE_IEN = COLL.CollectionSampleKey
	INNER JOIN ORDER_PRIORITY PRI
	ON O.Priority_IEN = PRI.OrderPriorityKey
	LEFT OUTER JOIN PROVIDER AS RPRO
	ON O.REQUESTING_PHYSICIAN_IEN = RPRO.ProviderKey
	LEFT OUTER JOIN PORTABLE
	ON O.PORTABLE = PORTABLE.PortableDesc
	LEFT OUTER JOIN MOBILITY_STATUS AS MOB
	ON O.MOBILITY_STATUS = MOB.MobilityStatusDesc
	LEFT OUTER JOIN vwMDE_ORDER_TASK_MAX AS TMAX 
	ON O.KEY_ORDER = TMAX.ORDER_IEN 
	LEFT OUTER JOIN vwMDE_ORDER_TASK AS TASK 
	ON TASK.KEY_ORDER_TASK = TMAX.MaxOrderTask
	INNER JOIN ORDER_STATUS AS STAT
	ON ISNULL(TASK.TASK_STATUS,'') = STAT.OrderStatusDesc
WHERE   (OT.OrderTypeId = 11) 
	AND (O.USER_SIG_DATE_TIME >= @fromDate)
UNION
SELECT 	O.KEY_ORDER, 
	O.ID_NUMBER, 
	PAT.PatientId, 
	OE.OrderEncounterTypeId, 
	OT.OrderTypeId, 
	LOC.HospitalLocationId, 
	PRO.ProviderId, 
    O.HCP_SIG_DATE_TIME, 
	ISNULL(O.ORDER_DATE_TIME,O.USER_SIG_DATE_TIME) AS OrderDateTime,
	ENC.PatientEncounterId, 
	O.PDTS_FILL_COST, 
	O.QUANTITY, 
    O.ANCILLARY_PROCEDURE_IEN AS OrderElementKey, 
	0 AS UnitCost,
	0 AS OrderCost,
	COLL.CollectionSampleId,
	PRI.OrderPriorityId,
	ISNULL(PRO.ProviderId,0),
	O.EARLIEST_TASK_DATE_TIME,
	O.NURSE_SIG_DATE_TIME,
	O.USER_SIG_DATE_TIME,
	ISNULL(PORTABLE.PortableId, 2),
	O.START_DATE_TIME,
	O.DISPLAY_TEXT,
	ISNULL(MOB.MobilityStatusId, 0),
	O.CLINICAL_IMPRESSION,
	STAT.OrderStatusId,
	0 AS SourceSystemId,
	NULL AS OrderComment
FROM   vwMDE_ORDER_ O 
	INNER JOIN PATIENT PAT 
	ON O.PATIENT_IEN = PAT.PatientKey 
	INNER JOIN ORDER_ENCOUNTER_TYPE OE 
	ON O.IN_OUTPATIENT = OE.OrderEncounterTypeDesc 
	INNER JOIN ORDER_TYPE OT 
	ON O.ORDER_TYPE_IEN = OT.OrderTypeKey 
	INNER JOIN HOSPITAL_LOCATION LOC 
	ON O.PATIENT_LOCATION_IEN = LOC.HospitalLocationKey 
	INNER JOIN PROVIDER PRO 
	ON O.ORDERING_HCP_IEN = PRO.ProviderKey 
	LEFT OUTER JOIN PATIENT_ENCOUNTER ENC 
	ON O.OUTPATIENT_ENCOUNTER_IEN = ENC.PatientAppointmentKey
	LEFT OUTER JOIN COLLECTION_SAMPLE COLL
	ON O.COLLECTION_SAMPLE_IEN = COLL.CollectionSampleKey
	INNER JOIN ORDER_PRIORITY PRI
	ON O.Priority_IEN = PRI.OrderPriorityKey
	LEFT OUTER JOIN PROVIDER AS RPRO
	ON O.REQUESTING_PHYSICIAN_IEN = RPRO.ProviderKey
	LEFT OUTER JOIN PORTABLE
	ON O.PORTABLE = PORTABLE.PortableDesc
	LEFT OUTER JOIN MOBILITY_STATUS AS MOB
	ON O.MOBILITY_STATUS = MOB.MobilityStatusDesc
	LEFT OUTER JOIN vwMDE_ORDER_TASK_MAX AS TMAX 
	ON O.KEY_ORDER = TMAX.ORDER_IEN 
	LEFT OUTER JOIN vwMDE_ORDER_TASK AS TASK 
	ON TASK.KEY_ORDER_TASK = TMAX.MaxOrderTask
	INNER JOIN ORDER_STATUS AS STAT
	ON ISNULL(TASK.TASK_STATUS,'') = STAT.OrderStatusDesc
WHERE   (OT.OrderTypeId = 5) 
	AND (O.USER_SIG_DATE_TIME >= @fromDate)
UNION
SELECT DISTINCT	O.KEY_ORDER, 
	O.ID_NUMBER, 
	PAT.PatientId, 
	OE.OrderEncounterTypeId, 
	OT.OrderTypeId, 
	LOC.HospitalLocationId, 
	PRO.ProviderId, 
    O.HCP_SIG_DATE_TIME, 
	ISNULL(O.ORDER_DATE_TIME,O.USER_SIG_DATE_TIME) AS OrderDateTime, 
	ENC.PatientEncounterId, 
	O.PDTS_FILL_COST, 
	O.QUANTITY, 
	NULL AS OrderElementKey, 
    0 AS UnitCost,
	0 AS OrderCost,
	COLL.CollectionSampleId,
	PRI.OrderPriorityId,
	ISNULL(PRO.ProviderId,0),
	O.EARLIEST_TASK_DATE_TIME,
	O.NURSE_SIG_DATE_TIME,
	O.USER_SIG_DATE_TIME,
	ISNULL(PORTABLE.PortableId, 2),
	O.START_DATE_TIME,
	O.DISPLAY_TEXT,
	ISNULL(MOB.MobilityStatusId, 0),
	O.CLINICAL_IMPRESSION,
	STAT.OrderStatusId,
	0 AS SourceSystemId,
	NULL AS OrderComment
FROM   vwMDE_ORDER_ O 
	INNER JOIN PATIENT PAT 
	ON O.PATIENT_IEN = PAT.PatientKey 
	INNER JOIN ORDER_ENCOUNTER_TYPE OE 
	ON O.IN_OUTPATIENT = OE.OrderEncounterTypeDesc 
	INNER JOIN ORDER_TYPE OT 
	ON O.ORDER_TYPE_IEN = OT.OrderTypeKey 
	INNER JOIN HOSPITAL_LOCATION LOC 
	ON O.PATIENT_LOCATION_IEN = LOC.HospitalLocationKey 
	INNER JOIN PROVIDER PRO 
	ON O.ORDERING_HCP_IEN = PRO.ProviderKey 
	LEFT OUTER JOIN PATIENT_ENCOUNTER ENC 
	ON O.OUTPATIENT_ENCOUNTER_IEN = ENC.PatientAppointmentKey
	LEFT OUTER JOIN COLLECTION_SAMPLE COLL
	ON O.COLLECTION_SAMPLE_IEN = COLL.CollectionSampleKey
	INNER JOIN ORDER_PRIORITY PRI
	ON O.Priority_IEN = PRI.OrderPriorityKey
	LEFT OUTER JOIN PROVIDER AS RPRO
	ON O.REQUESTING_PHYSICIAN_IEN = RPRO.ProviderKey
	LEFT OUTER JOIN PORTABLE
	ON O.PORTABLE = PORTABLE.PortableDesc
	LEFT OUTER JOIN MOBILITY_STATUS AS MOB
	ON O.MOBILITY_STATUS = MOB.MobilityStatusDesc
	LEFT OUTER JOIN vwMDE_ORDER_TASK_MAX AS TMAX 
	ON O.KEY_ORDER = TMAX.ORDER_IEN 
	LEFT OUTER JOIN vwMDE_ORDER_TASK AS TASK 
	ON TASK.KEY_ORDER_TASK = TMAX.MaxOrderTask
	INNER JOIN ORDER_STATUS AS STAT
	ON ISNULL(TASK.TASK_STATUS,'') = STAT.OrderStatusDesc
WHERE   (OT.OrderTypeId NOT IN (5, 11, 15, 16)) 
	AND (O.USER_SIG_DATE_TIME >= @fromDate)

UNION
SELECT CAST(CAST(ORD.ESSPatientKey AS nvarchar(50)) + CAST(ORD.ChainId AS nvarchar(10)) AS numeric) AS KeyOrder, 
	CAST(ORD.ESSPatientKey AS nvarchar(50)) + '-' + CAST(ORD.ChainId AS nvarchar(10)) AS IDNumber,
	ORD.PatientKey,
	0 AS OrderEncounterTypeId,
	TYP.OrderTypeId,
	3058 AS HospitalLocationId,
	ISNULL(PRO.ProviderId,0) AS ProviderId,
	ORD.OrderTime,
	ORD.OrderTime AS OrderDateTime,
	0 AS PatientEncounterId,
	0 AS PDTSFillCost,
	0 AS Qty,
	NULL AS OrderElementKey,
	0 AS UnitCost,
	0 AS OrderCost,
	NULL AS CollectionSampleId,
	CASE ORD.[Priority]
		WHEN 'NOW (1 hour)' THEN 8
		WHEN 'ROUTINE' THEN 7
		WHEN 'PRN' THEN 4
		WHEN 'NOW' THEN 8
		ELSE 0
	END AS OrderPriority,
	0 AS Expr1,
	ORD.OrderTime AS EarliestTaskDateTime,
	NULL AS NurseSigDateTime,
	ORD.OrderTime AS UserSigDateTime,
	2 AS PortableId,
	ORD.StartTime,
	ORD.OrderName + ' |' + ORD.SetName AS DisplayText,
	0 AS MobilityStatusId,
	NULL AS ClinicalImpression,
	0 AS OrderStatusId,
	16 AS SourceSystemId,
	ORD.OrderComments AS OrderComment
FROM dbo.vwESS_ORDER_NEW AS ORD
	INNER JOIN PATIENT AS PAT
	ON ORD.PatientKey = PAT.PatientKey
	INNER JOIN ORDER_TYPE AS TYP
	ON ORD.OrderTypeName = TYP.OrderTypeDesc
	LEFT JOIN PROVIDER AS PRO
	ON REPLACE(ORD.ProviderName,', ',',') = PRO.ProviderName
	AND PRO.ProviderKey > 0

--ORDER BY O.KEY_ORDER

OPEN curOrder
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch Order',0

FETCH NEXT FROM curOrder INTO @ord,@num,@pat,@inout,@type,@loc,@pro,@sigdate,
	@date,@appt,@cost,@qty,@elm,@unit,@ocost,@coll,@pri,@req,@etd,@nsd,
	@usr,@port,@sdt,@txt,@mob,@imp,@stat,@ss,@com

if(@@FETCH_STATUS = 0)

BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@ordX = OrderKey,
			@numX = OrderNumber,
			@patX = PatientId,
			@inoutX = OrderEncounterTypeId,
			@typeX = OrderTypeId,
			@locX = LocationId,
			@proX = OrderingProviderId,
			@sigdateX = SigDateTime,
			@dateX = OrderDateTime,
			@apptX = PatientEncounterId,
			@costX = PdtsFillCost,
			@qtyX = Quantity,
			@elmX = OrderElementKey,
			@unitX = UnitCost,
			@ocostX = OrderCost,
			@collX = CollectionSampleId,
			@priX = OrderPriorityId,
			@reqX = RequestingProviderId,
			@etdX = EarliestTaskDate,
			@nsdX = NurseSigDateTime,
			@usrX = UserSigDateTime,
			@portX = PortableId,
			@sdtX = StartDateTime,
			@txtX = DisplayText,
			@mobX = MobilityStatusId,
			@impX = ClinicalImpression,
			@statX = OrderStatusId,
			@comX = OrderComment
		FROM NHJAX_ODS.dbo.PATIENT_ORDER
		WHERE OrderKey = @ord
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.PATIENT_ORDER(
				OrderKey,
				OrderNumber,
				PatientId,
				OrderEncounterTypeId,
				OrderTypeId,
				LocationId,
				OrderingProviderId,
				SigDateTime,
				OrderDateTime,
				PatientEncounterId,
				PdtsFillCost,
				Quantity,
				OrderElementKey,
				UnitCost,
				OrderCost,
				CollectionSampleId,
				OrderPriorityId,
				RequestingProviderId,
				EarliestTaskDate,
				NurseSigDateTime,
				UserSigDateTime,
				PortableId,
				StartDateTime,
				DisplayText,
				MobilityStatusId,
				ClinicalImpression,
				OrderStatusId,
				SourceSystemId,
				OrderComment)
				VALUES(@ord,@num,@pat,@inout,@type,@loc,@pro,@sigdate,@date,
				@appt,@cost,@qty,@elm,@unit,@ocost,@coll,@pri,@req,@etd,@nsd,
				@usr,@port,@sdt,@txt,@mob,@imp,@stat,@ss,@com);
				SET @irow = @irow + 1
			END
		ELSE
			BEGIN
		
			
			IF @num <> @numX
			OR (@num Is Not Null AND @numX Is Null)
			BEGIN
				UPDATE PATIENT_ORDER
				SET OrderNumber = @num,
					UpdatedDate = GETDATE()
				WHERE OrderKey = @ord;
			END
			
			IF @pat <> @patX
			OR (@pat Is Not Null AND @patX Is Null)
			BEGIN
				UPDATE PATIENT_ORDER
				SET PatientId = @pat,
					UpdatedDate = GETDATE()
				WHERE OrderKey = @ord;
			END
			
			IF @inout <> @inoutX
			OR (@inout Is Not Null AND @inoutX Is Null)
			BEGIN
				UPDATE PATIENT_ORDER
				SET OrderEncounterTypeId = @inout,
					UpdatedDate = GETDATE()
				WHERE OrderKey = @ord;
			END
			
			IF @type <> @typeX
			OR (@type Is Not Null AND @typeX Is Null)
			BEGIN
				UPDATE PATIENT_ORDER
				SET OrderTypeId = @type,
					UpdatedDate = GETDATE()
				WHERE OrderKey = @ord;
			END
			
			IF @loc <> @locX
			OR (@loc Is Not Null AND @locX Is Null)
			BEGIN
				UPDATE PATIENT_ORDER
				SET OrderNumber = @loc,
					UpdatedDate = GETDATE()
				WHERE OrderKey = @ord;
			END
			
			IF @pro <> @proX
			OR (@pro Is Not Null AND @proX Is Null)
			BEGIN
				UPDATE PATIENT_ORDER
				SET OrderingProviderId = @pro,
					UpdatedDate = GETDATE()
				WHERE OrderKey = @ord;
			END
			
			IF @sigdate <> @sigdateX
			OR (@sigdate Is Not Null AND @sigdateX Is Null)
			BEGIN
				UPDATE PATIENT_ORDER
				SET SigDateTime = @sigdate,
					UpdatedDate = GETDATE()
				WHERE OrderKey = @ord;
			END
			
			IF @date <> @dateX
			OR (@date Is Not Null AND @dateX Is Null)
			BEGIN
				UPDATE PATIENT_ORDER
				SET OrderDateTime = @date,
					UpdatedDate = GETDATE()
				WHERE OrderKey = @ord;
			END
			
			IF @appt <> @apptX
			OR (@appt Is Not Null AND @apptX Is Null)
			BEGIN
				UPDATE PATIENT_ORDER
				SET PatientEncounterId = @appt,
					UpdatedDate = GETDATE()
				WHERE OrderKey = @ord;
			END
			
			IF @cost <> @costX
			OR (@cost Is Not Null AND @costX Is Null)
			BEGIN
				UPDATE PATIENT_ORDER
				SET PdtsFillCost = @cost,
					UpdatedDate = GETDATE()
				WHERE OrderKey = @ord;
			END
			
			IF @unit <> @unitX
			OR (@unit Is Not Null AND @unitX Is Null)
			BEGIN
				UPDATE PATIENT_ORDER
				SET UnitCost = @unit,
					UpdatedDate = GETDATE()
				WHERE OrderKey = @ord;
			END
			
			IF @ocost <> @ocostX
			OR (@ocost Is Not Null AND @ocostX Is Null)
			BEGIN
				UPDATE PATIENT_ORDER
				SET OrderCost = @ocost,
					UpdatedDate = GETDATE()
				WHERE OrderKey = @ord;
			END
			
			IF @coll <> @collX
			OR (@coll Is Not Null AND @collX Is Null)
			BEGIN
				UPDATE PATIENT_ORDER
				SET CollectionSampleId = @coll,
					UpdatedDate = GETDATE()
				WHERE OrderKey = @ord;
			END
			
			IF @pri <> @priX
			OR (@pri Is Not Null AND @priX Is Null)
			BEGIN
				UPDATE PATIENT_ORDER
				SET OrderPriorityId = @pri,
					UpdatedDate = GETDATE()
				WHERE OrderKey = @ord;
			END
			
			--Separated out Order Element to handle unexplained
			--clearing of ancillary procedure key.
			IF	@elm <> @elmX
			OR	(@elm Is Not Null AND @elmX Is Null)
			BEGIN
				UPDATE PATIENT_ORDER
				SET OrderElementKey = @elm,
					UpdatedDate = GETDATE()
				WHERE OrderKey = @ord;
			END
			
			IF @req <> @reqX
			OR (@req Is Not Null AND @reqX Is Null)
			BEGIN
				UPDATE PATIENT_ORDER
				SET RequestingProviderId = @req,
					UpdatedDate = GETDATE()
				WHERE OrderKey = @ord;
			END
			
			IF @etd <> @etdX
			OR (@etd Is Not Null AND @etdX Is Null)
			BEGIN
				UPDATE PATIENT_ORDER
				SET EarliestTaskDate = @etd,
				UpdatedDate = GETDATE()
				WHERE OrderKey = @ord;
			END
			
			IF @nsd <> @nsdX
			OR (@nsd Is Not Null AND @nsdX Is Null)
			BEGIN
				UPDATE PATIENT_ORDER
				SET NurseSigDateTime = @nsd,
					UpdatedDate = GETDATE()
				WHERE OrderKey = @ord;
			END
			
			IF @usr <> @usrX
			OR (@usr Is Not Null AND @usrX Is Null)
			BEGIN
				UPDATE PATIENT_ORDER
				SET UserSigDateTime = @usr,
					UpdatedDate = GETDATE()
				WHERE OrderKey = @ord;
			END
			
			IF @port <> @portX
			OR (@port Is Not Null AND @portX Is Null)
			BEGIN
				UPDATE PATIENT_ORDER
				SET PortableId = @port,
				UpdatedDate = GETDATE()
				WHERE OrderKey = @ord;
			END
			
			IF @sdt <> @sdtX
			OR (@sdt Is Not Null AND @sdtX Is Null)
			BEGIN
				UPDATE PATIENT_ORDER
				SET StartDateTime = @sdt,
				UpdatedDate = GETDATE()
				WHERE OrderKey = @ord;
			END
			
			IF @txt <> @txtX
			OR (@txt Is Not Null AND @txtX Is Null)
			BEGIN
				UPDATE PATIENT_ORDER
				SET DisplayText = @txt,
				UpdatedDate = GETDATE()
				WHERE OrderKey = @ord;
			END
			
			IF @mob <> @mobX
			OR (@mob Is Not Null AND @mobX Is Null)
			BEGIN
				UPDATE PATIENT_ORDER
				SET MobilityStatusId = @mob,
				UpdatedDate = GETDATE()
				WHERE OrderKey = @ord;
			END
			
			IF @imp <> @impX
			OR (@imp Is Not Null AND @impX Is Null)
			BEGIN
				UPDATE PATIENT_ORDER
				SET ClinicalImpression = @imp,
				UpdatedDate = GETDATE()
				WHERE OrderKey = @ord;
			END
			
			IF (@stat <> @statX AND @stat <> 47)
				OR(@stat IS NOT NULL AND @statX IS NULL)
			BEGIN
				UPDATE PATIENT_ORDER
				SET OrderStatusId = @stat,
				UpdatedDate = GETDATE()
				WHERE OrderKey = @ord;
			END

			IF (@com <> @comX AND @com  IS NOT NULL)
				OR(@com IS NOT NULL AND @comX IS NULL)
			BEGIN
				UPDATE PATIENT_ORDER
				SET OrderComment = @com,
				UpdatedDate = GETDATE()
				WHERE OrderKey = @ord;
			END
			
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM curOrder INTO @ord,@num,@pat,@inout,@type,@loc,@pro,@sigdate,
			@date,@appt,@cost,@qty,@elm,@unit,@ocost,@coll,@pri,@req,@etd,@nsd,
			@usr,@port,@sdt,@txt,@mob,@imp,@stat,@ss,@com
	COMMIT	
	END
END

CLOSE curOrder
DEALLOCATE curOrder

SET @surow = 'Order Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Order Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Order Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Order',0,@day;
