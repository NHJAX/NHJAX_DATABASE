
CREATE PROCEDURE [dbo].[upCP_Patient_Detail]
(
@pat Int
)

AS
--
--	DECLARE @TempDate DATETIME
--	DECLARE @FromDate DATETIME
--	
--SET @tempDate = DATEADD(d,-3,getDate());
--SET @fromDate = dbo.StartOfDay(@tempDate);

SELECT
	P.PatientId, 
	P.FullName, 
	P.Sex,
	P.DOB,
	ISNULL(P.Phone, '--') AS Home, 
	ISNULL(P.OfficePhone, '--') AS Work,
	P.StreetAddress1,
	ISNULL (P.StreetAddress2, '') As Address2,
	ISNULL (P.StreetAddress3, '') As Address3,
	P.City,
	P.StateId,
	P.ZipCode

	
FROM       PATIENT AS P INNER JOIN
           vwCP_PATIENT_FLAG AS PF ON P.PatientId = PF.PatientId
			
WHERE     (P.PatientId = @pat)



