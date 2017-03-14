
CREATE PROCEDURE [dbo].[upODS_DM_CIP_Purge_3Days]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;
DECLARE @start datetime

SET @start = dbo.startofday(DATEADD(d,-3,getdate()))

   -- Purge Session Information from CIP DataMart
delete from cip.dbo.DM_CIP_CLINIC_AHLTA_UTILIZATION
where createddate < @start


delete from cip.dbo.DM_CIP_CLINIC_REPORT_CARD
where createddate < @start


delete from cip.dbo.DM_CIP_CLINIC_TOP_CPT
where createddate < @start


delete from cip.dbo.DM_CIP_CLINIC_TOP_EM
where createddate < @start


delete from cip.dbo.DM_CIP_CLINIC_TOP_ICD
where createddate < @start


delete from cip.dbo.DM_CIP_CPT_TOP_CPT_BREAKDOWN
where createddate < @start


delete from cip.dbo.DM_CIP_CPT_TOP_CPT_BREAKDOWN_PRO
where createddate < @start


delete from cip.dbo.DM_CIP_CPT_TOP_CPT_RANK
where createddate < @start


delete from cip.dbo.DM_CIP_EM_TOP_CPT_BREAKDOWN
where createddate < @start


delete from cip.dbo.DM_CIP_EM_TOP_CPT_BREAKDOWN_PRO
where createddate < @start


delete from cip.dbo.DM_CIP_EM_TOP_CPT_RANK
where createddate < @start


--delete from cip.dbo.DM_CIP_ENCOUNTER
--where createddate < @start


--delete from cip.dbo.DM_CIP_ENCOUNTER_CPT
--where createddate < @start


--delete from cip.dbo.DM_CIP_ENCOUNTER_DIAG
--where createddate < @start


--delete from cip.dbo.DM_CIP_ENCOUNTER_DTL_CODE
--where createddate < @start


delete from cip.dbo.DM_CIP_ICD_TOP_BREAKDOWN
where createddate < @start


delete from cip.dbo.DM_CIP_ICD_TOP_BREAKDOWN_PRO
where createddate < @start


delete from cip.dbo.DM_CIP_ICD_TOP_RANK
where createddate < @start


--delete from DM_CIP_METRIC_TYPE
--where createddate > @start


--delete from cip.dbo.DM_CIP_ORDER
--where createddate < @start


delete from cip.dbo.DM_CIP_PROVIDER_AHLTA_UTILIZATION
where createddate < @start


delete from cip.dbo.DM_CIP_PROVIDER_REPORT_CARD
where createddate < @start

delete from cip.dbo.DM_CIP_PROVIDER_TOP_CPT
where createddate < @start

delete from cip.dbo.DM_CIP_PROVIDER_TOP_EM
where createddate < @start

delete from cip.dbo.DM_CIP_PROVIDER_TOP_ICD
where createddate < @start

end


