

create PROCEDURE [dbo].[upCP_Patient_GetSuggestions]
(
@name nvarchar(50)
)

AS
--
--	DECLARE @TempDate DATETIME
--	DECLARE @FromDate DATETIME
--	
--SET @tempDate = DATEADD(d,-3,getDate());
--SET @fromDate = dbo.StartOfDay(@tempDate);

SELECT DISTINCT 		P.Fullname						

FROM         PATIENT as P
WHERE     (P.fullname like @name)
AND P.PatientCategoryID NOT IN (SELECT PATIENTCATEGORYID
								 FROM PATIENT_CATEGORY
								 WHERE (PATIENTCATEGORYCODE LIKE '%00%')
								  OR (PatientCategoryCode LIKE '%45%') 
								  OR (PatientCategoryCode LIKE '%47%'))

ORDER BY P.FULLNAME