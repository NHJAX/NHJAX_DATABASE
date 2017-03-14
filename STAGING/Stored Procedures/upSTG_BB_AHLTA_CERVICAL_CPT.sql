create Procedure [dbo].[upSTG_BB_AHLTA_CERVICAL_CPT]
AS
	
EXEC dbo.upActivityLog 'Begin Bit Bucket AHLTA Cervical',0;

INSERT INTO BIT_BUCKET_AHLTA_CERVICAL_CPT
(
	[FMP Sponsor SSN], 
	[Full Name], 
	[Appointment Id], 
	[Appointment Date/Time], 
	[Appointment Status], 
	[Appointment Type], 
	[Encounter Id], 
	[CPT4 Code], 
	FMP, 
	SponsorSSN
)
(
SELECT
	CERV.[FMP Sponsor SSN], 
	CERV.[Full Name], 
	CERV.[Appointment Id], 
	CERV.[Appointment Date/Time], 
	CERV.[Appointment Status], 
	CERV.[Appointment Type], 
	CERV.[Encounter Id], 
	CERV.[CPT4 Code], 
	FMP.FMP, 
	CERV.SponsorSSN
FROM FAMILY_MEMBER_PREFIX AS FMP 
	INNER JOIN PATIENT AS PAT 
	ON FMP.KEY_FAMILY_MEMBER_PREFIX = PAT.FMP_IEN 
	RIGHT OUTER JOIN AHLTA_CERVICAL_CPT AS CERV 
	ON FMP.FMP = CERV.FMP 
	AND PAT.SPONSOR_SSN = CERV.SponsorSSN
WHERE  (PAT.KEY_PATIENT IS NULL)
)

EXEC dbo.upActivityLog 'End Bit Bucket AHLTA Cervical',0;
