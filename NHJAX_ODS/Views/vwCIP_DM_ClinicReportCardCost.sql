﻿create VIEW [dbo].[vwCIP_DM_ClinicReportCardCost] 

AS


SELECT 	
	LOC.HOSPITALLOCATIONID AS CLINICID, 
	LOC.HOSPITALLOCATIONNAME AS CLINICNAME, 
	ORD.ORDERCOST AS METRIC, 
	1 AS TYPE,
	ORD.ORDERDATETIME,
	MPR.DMISID
FROM 		
	HOSPITAL_LOCATION LOC 
	INNER JOIN PATIENT_ORDER ORD 
	ON ORD.LOCATIONID = LOC.HOSPITALLOCATIONID
	INNER JOIN PROVIDER PRO 
	ON PRO.PROVIDERID = ORD.ORDERINGPROVIDERID
	INNER JOIN MEPRS_CODE MPR 
	ON MPR.MEPRSCODEID = LOC.MEPRSCODEID
WHERE	ORD.ORDERTYPEID = '11'
		AND PRO.PROVIDERFLAG = '1'

UNION
SELECT 	
	LOC.HOSPITALLOCATIONID AS CLINICID, 
	LOC.HOSPITALLOCATIONNAME AS CLINICNAME, 
	ORD.ORDERCOST AS METRIC, 
	2 AS TYPE,
	ORD.ORDERDATETIME,
	MPR.DMISID
FROM 		
	HOSPITAL_LOCATION LOC 
	INNER JOIN PATIENT_ORDER ORD 
	ON ORD.LOCATIONID = LOC.HOSPITALLOCATIONID
	INNER JOIN PROVIDER PRO 
	ON PRO.PROVIDERID = ORD.ORDERINGPROVIDERID
	INNER JOIN	MEPRS_CODE MPR ON MPR.MEPRSCODEID = LOC.MEPRSCODEID
WHERE	ORD.ORDERTYPEID = '15'
		AND PRO.PROVIDERFLAG = '1'


UNION
SELECT 	
	LOC.HOSPITALLOCATIONID AS CLINICID, 
	LOC.HOSPITALLOCATIONNAME AS CLINICNAME, 
	ORD.ORDERCOST AS METRIC,
	3 AS TYPE,
	ORD.ORDERDATETIME,
	MPR.DMISID
FROM 		
	HOSPITAL_LOCATION LOC 
	INNER JOIN PATIENT_ORDER ORD 
	ON ORD.LOCATIONID = LOC.HOSPITALLOCATIONID
	INNER JOIN	PROVIDER PRO 
	ON PRO.PROVIDERID = ORD.ORDERINGPROVIDERID
	INNER JOIN	MEPRS_CODE MPR 
	ON MPR.MEPRSCODEID = LOC.MEPRSCODEID
WHERE	ORD.ORDERTYPEID = '16'
		AND PRO.PROVIDERFLAG = '1'

UNION
SELECT 	
	LOC.HOSPITALLOCATIONID AS CLINICID, 
	LOC.HOSPITALLOCATIONNAME AS CLINICNAME, 
	ORD.ORDERID AS METRIC, 
	4 AS TYPE,
	ORD.ORDERDATETIME,
	MPR.DMISID
FROM 		
	HOSPITAL_LOCATION LOC 
	INNER JOIN PATIENT_ORDER ORD 
	ON ORD.LOCATIONID = LOC.HOSPITALLOCATIONID
	INNER JOIN PROVIDER PRO 
	ON PRO.PROVIDERID = ORD.ORDERINGPROVIDERID
	INNER JOIN MEPRS_CODE MPR 
	ON MPR.MEPRSCODEID = LOC.MEPRSCODEID
WHERE	ORD.ORDERTYPEID = '5'
		AND PRO.PROVIDERFLAG = '1'

