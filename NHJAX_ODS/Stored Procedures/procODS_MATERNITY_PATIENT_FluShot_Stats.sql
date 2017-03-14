-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[procODS_MATERNITY_PATIENT_FluShot_Stats]
WITH EXEC AS CALLER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	----*********************************************************
	--DECLARE @CurrentMonth as int
	--DECLARE @CurrentYear as int
	--DECLARE @BeginDate as datetime	
	----*********************************************************
	--DECLARE @TotalMaternityPatients int
	--DECLARE @TotalHaves int
	--DECLARE @TotalHaveNots int
	--DECLARE @PercentHave decimal(5,2)
	--DECLARE @PercentHaveNot decimal(5,2)
	----*****  COMPUTE THE BEGINING DATE  ***********************
	--SET @CurrentMonth = DATEPART(month,getdate())
	--SET @CurrentYear = DATEPART(year,getdate())
	--IF @CurrentMonth > 7
	--	BEGIN
	--		SET @BeginDate = CONVERT(datetime,'08/01/' + CONVERT(char(4),@CurrentYear))
	--	END
	--ELSE
	--	BEGIN
	--		IF @CurrentMonth < 4
	--			BEGIN
	--				SET @BeginDate = CONVERT(datetime,'08/01/' + CONVERT(char(4),@CurrentYear - 1))
	--			END
	--		ELSE
	--			BEGIN
	--				SET @BeginDate = getdate()
	--			END
	--	END
	----**********  T O T A L  M A T E R N I T Y  P A T I E N T S  ******************	
	--SELECT     @TotalMaternityPatients = COUNT(PatientFlagId)
	--FROM         PATIENT_FLAG
	--WHERE     (FlagId = 17)
	----**********  T O T A L  H A V E  N O T  H A D  F L U  S H O T S   ************
	--SELECT     @TotalHaveNots = COUNT(PatientFlagId)
	--FROM         PATIENT_FLAG
	--WHERE     (FlagId = 17) AND (PatientId NOT IN 
	--	(SELECT DISTINCT ENC.PatientId
	--	FROM PATIENT_PROCEDURE AS PP 
	--	INNER JOIN PATIENT_ENCOUNTER AS ENC 
	--	ON PP.PatientEncounterId = ENC.PatientEncounterId
	--	WHERE (PP.CptId IN (9210, 13102, 18007, 13118, 13119, 14196,
	--	15846, 15848, 13117, 18955, 18956, 18957, 7085, 14471, 14472, 14473, 14474, 
	--	14475, 14476, 14478, 14479, 14480, 7076,
	--	14477)) AND (PP.ProcedureDateTime > @BeginDate)))
	----**********  T O T A L  H A V E   H A D  F L U  S H O T S   *******************
	--SELECT     @TotalHaves = COUNT(PatientFlagId)
	--FROM         PATIENT_FLAG
	--WHERE     (FlagId = 17) AND (PatientId IN
	--	  (SELECT DISTINCT ENC.PatientId
	--		FROM          PATIENT_PROCEDURE AS PP INNER JOIN
	--							   PATIENT_ENCOUNTER AS ENC ON
	--PP.PatientEncounterId = ENC.PatientEncounterId
	--		WHERE      (PP.CptId IN (9210, 13102, 18007, 13118, 13119, 14196,
	--15846, 15848, 13117, 18955, 18956, 18957, 7085, 14471, 14472, 14473, 14474, 
	--							   14475, 14476, 14478, 14479, 14480, 7076,
	--14477)) AND (PP.ProcedureDateTime > @BeginDate)))
	----*****************     GET THE PERCENTAGES    **************************************************
	--SET @PercentHaveNot = (CAST(@TotalHaveNots as decimal(5,2)) / CAST(@TotalMaternityPatients as Decimal(5,2)) * 100)
	--SET @PercentHave = (CAST(@TotalHaves as decimal(5,2)) / CAST(@TotalMaternityPatients as decimal(5,2)) * 100)
	----*****************     OUTPUT THE RESULTS     **************************************************
	--SELECT	@TotalMaternityPatients as TotalPatients, 
	--		@TotalHaveNots as TotalHaveNots, 
	--		@TotalHaves as TotalHaves,
	--		@PercentHaveNot as PercentHaveNot,
	--		@PercentHave as PercentHave
	
	SELECT TotalPatients,
		TotalHaveNots,
		TotalHaves,
		PercentHaveNot,
		PercentHave,
    TDAPTotalHaves,
    TDAPTotalHaveNots,
    TDAPPercentHave,
    TDAPPercentHaveNot,
    TotalGestationalDiabetic, 
    PercentGestationalDiabetic,
    TotalTobaccoUsers,
    PercentTobaccoUsers,
    TotalTDAPMaternityPatients
	FROM dbo.vwCP_FLU_STAT
END