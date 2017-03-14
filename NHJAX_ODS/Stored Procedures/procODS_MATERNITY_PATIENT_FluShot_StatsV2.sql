-- =============================================
-- Author:		Robert Evans
-- Create date: 25 Jan 2016
-- Description:	Same as V1 except for Param which aren't used.
-- =============================================
CREATE PROCEDURE procODS_MATERNITY_PATIENT_FluShot_StatsV2 
	@ParameterTable dbo.ProcedureParameters READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

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
