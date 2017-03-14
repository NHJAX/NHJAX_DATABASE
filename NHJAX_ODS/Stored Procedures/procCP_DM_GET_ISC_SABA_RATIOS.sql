
CREATE PROCEDURE [dbo].[procCP_DM_GET_ISC_SABA_RATIOS]
AS
BEGIN
	
	SET NOCOUNT ON;
		SELECT SABA.[ICSSABARatioId]
			  ,SABA.[PatientId]
			  ,SABA.[FullName]
			  ,SABA.[SponsorSSN]
			  ,dbo.FormatDateWithoutTime(SABA.[DOB],2) as DOB
			  ,SABA.[Age]
			  ,SABA.[PCMId]
			  ,SABA.[PCMName]
			  ,SABA.[Hospitalizations]
			  ,SABA.[OutpatientVisits]
			  ,SABA.[ERVisits]
			  ,SABA.[DispensingEvents]
			  ,SABA.[ICSId]
			  ,SABA.[ControlICSDesc]
			  ,SABA.[ICSLastFill]
			  ,SABA.[SABAId]
			  ,SABA.[SABADesc]
			  ,SABA.[SABALastFill]
			  ,SABA.[ICSCount]
			  ,SABA.[SABACount],
			  PAT.Sex     
		  FROM [NHJAX_ODS].[dbo].[DM_ASTHMA_ISC_SABA_DETAILS] AS SABA
		  INNER JOIN PATIENT AS PAT
		  ON PAT.PatientId = SABA.PatientId
END
