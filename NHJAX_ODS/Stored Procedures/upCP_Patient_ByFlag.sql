
CREATE PROCEDURE [dbo].[upCP_Patient_ByFlag]
(
@Flag int
--@usr int
)

AS
--
--	DECLARE @TempDate DATETIME
--	DECLARE @FromDate DATETIME
--	
--SET @tempDate = DATEADD(d,-3,getDate());
--SET @fromDate = dbo.StartOfDay(@tempDate);

SELECT --top (100)
	P.PatientId, 
	P.FullName, 
	P.Sex,
	P.DOB,
	ISNULL(P.Phone, '--') AS Home, 
	ISNULL(P.OfficePhone, '--') AS Work

	
FROM       PATIENT AS P INNER JOIN
           vwCP_PATIENT_FLAG AS PF ON P.PatientId = PF.PatientId
WHERE     (PF.FlagId = @flag)



