create PROCEDURE [dbo].[procSTG_BIT_BUCKET_CDM_ADDITIONAL_PROVIDER_Insert]

AS
	SET NOCOUNT ON;
INSERT INTO BIT_BUCKET_CDM_ADDITIONAL_PROVIDER
(     
	[Appointment Id], 
	[Appointment Date/Time], 
	[FMP Sponsor SSN], 
	[Appointment Provider Role], 
	[Additional Provider], 
	FMP, 
	[Sponsor SSN], 
	[Full Name], 
	DOB
)
SELECT     
	[Appointment Id], 
	[Appointment Date/Time], 
	[FMP Sponsor SSN], 
	[Appointment Provider Role], 
	[Additional Provider], 
	FMP, 
	[Sponsor SSN], 
	[Full Name], 
	DOB
FROM ADDITIONAL_PROVIDER
WHERE ([Additional Provider] NOT IN
	(SELECT AP.[Additional Provider]
     FROM ADDITIONAL_PROVIDER AS AP 
		INNER JOIN vwODS_PROVIDER AS PRO 
		ON AP.[Additional Provider] = PRO.ProviderName)
	)
