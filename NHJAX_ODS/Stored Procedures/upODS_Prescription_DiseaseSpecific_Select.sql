
CREATE PROCEDURE [dbo].[upODS_Prescription_DiseaseSpecific_Select]
(
	@dm bigint,
	@flg int,
	@debug bit = 0
)
 AS

DECLARE	
	@sql		nvarchar(4000),
	@dsd		varchar(5000),
	@paramlist	nvarchar(4000),
	@defdt		varchar(20),
	@start		datetime
	
--SET @start = dbo.StartOfDay(DATEADD(m, - 24, GETDATE()))

delete from DISPENSING_EVENT
where diseasemanagementid = @dm

SELECT @dsd = dbo.SpecificDrugs(@dm)

SET @defdt = "'" + '1/1/1900' + "'"

SELECT @sql = '
INSERT INTO DISPENSING_EVENT
(
	PrescriptionId,
	RXNumber,
	DrugDesc,
	DaysSupply,
	MaxFillDate,
	PharmacyDesc,
	SourceSystemId,
	DiseaseManagementId,
	PatientId
)			
SELECT DISTINCT
			PRE.PrescriptionId,
			PRE.RXNumber, 
			DRUG.DrugDesc,
			PRE.DaysSupply,
			PRE.MaxFillDate,
			PRE.PharmacyDesc,
			PRE.SourceSystemId,
			@dm AS DiseaseManagementId,
			PRE.PatientId
			FROM vwODS_DM_PRESCRIPTION PRE
			INNER JOIN DRUG
			ON PRE.DrugId = DRUG.DrugId
			INNER JOIN PATIENT_FLAG PF
			ON PF.PatientId = PRE.PatientId
		WHERE 
			1 = 1 '

IF DataLength(@dsd) > 0
	SELECT @sql = @sql + 'AND (' + @dsd + ')'

SELECT @sql = @sql + ' AND PF.FlagId = @flg'

SELECT @sql = @sql + ' AND (PRE.MaxFillDate >= dbo.StartOfDay(DATEADD(m, - 24, GETDATE())) 
OR PRE.MaxFillDate = ' + @defdt + ') '

IF @debug = 1
	PRINT @sql
	PRINT @dsd
	PRINT @flg

SELECT @paramlist = 	'@flg int, @dm bigint'
			
EXEC sp_executesql	@sql, @paramlist, @flg, @dm



