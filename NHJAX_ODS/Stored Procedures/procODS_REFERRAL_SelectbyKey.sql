
CREATE PROCEDURE [dbo].[procODS_REFERRAL_SelectbyKey] 
(
	@key decimal(17,3)
)
AS
BEGIN
	
	SET NOCOUNT ON;

    SELECT     
		REF.ReferralId, 
		REF.ReferralKey, 
		REF.ReferralDate, 
		REF.ReasonForReferral, 
		ISNULL(REF.ReferredToProviderId,0) AS ReferredToProviderId, 
		ISNULL(REF.ReferredToLocationId,0) AS ReferredToLocationId, 
		ISNULL(REF.ReferredByProviderId,0) AS ReferredByProviderId, 
		ISNULL(REF.ReferredByLocationId,0) AS ReferredByLocationId, 
		ISNULL(REF.PatientOrderId,0) AS PatientOrderId, 
		REF.CreatedDate, 
		REF.UpdatedDate, 
		ISNULL(REF.PatientId,0) AS PatientId, 
		REF.NumberofVisits, 
		REF.ReferralNumber, 
		ISNULL(REF.PriorityId,0) AS PriorityId, 
		ISNULL(RTP.ProviderKey,0) AS ReferToProviderKey, 
		ISNULL(RTL.HospitalLocationKey,0) AS ReferToLocationKey, 
		ISNULL(RBP.ProviderKey,0) AS ReferByProviderKey, 
		ISNULL(RBL.HospitalLocationKey,0) AS ReferByLocationKey, 
		ISNULL(ORD.OrderKey,0) AS OrderKey, 
		ISNULL(PAT.PatientKey,0) AS PatientKey
	FROM REFERRAL AS REF 
		LEFT OUTER JOIN PROVIDER AS RBP 
		ON REF.ReferredByProviderId = RBP.ProviderId 
		LEFT OUTER JOIN HOSPITAL_LOCATION AS RBL 
		ON REF.ReferredByLocationId = RBL.HospitalLocationId 
		LEFT OUTER JOIN PROVIDER AS RTP 
		ON REF.ReferredToProviderId = RTP.ProviderId 
		LEFT OUTER JOIN HOSPITAL_LOCATION AS RTL 
		ON REF.ReferredToLocationId = RTL.HospitalLocationId 
		LEFT OUTER JOIN PATIENT_ORDER AS ORD 
		ON REF.PatientOrderId = ORD.OrderId 
		LEFT OUTER JOIN PATIENT AS PAT 
		ON REF.PatientId = PAT.PatientId 
		LEFT OUTER JOIN PRIORITY AS PRI 
		ON REF.PriorityId = PRI.PriorityId		
	WHERE REF.ReferralKey = @key
END





