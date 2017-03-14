create PROCEDURE [dbo].[procSTG_CHCS_PRESCRIPTION_Insert]
(
	@key numeric(14,3),
	@rx varchar(10),
	@pat numeric(21,3),
	@pro numeric(21,3),
	@drug numeric(21,3),
	@fill datetime,
	@dord datetime,
	@onum varchar(12),
	@ord numeric(21,3),
	@exp varchar(15),
	@stat varchar(30)
)
AS
	SET NOCOUNT ON;
INSERT INTO CHCS_PRESCRIPTION
(     
	KEY_PRESCRIPTION, 
	RX_#, 
	PATIENT_IEN, 
	PROVIDER_IEN, 
	DRUG_IEN, 
	LAST_FILL_DATE, 
	ORDER_DATE_TIME, 
	ORDER_ENTRY_NUMBER, 
	ORDER_POINTER_IEN, 
	EXPIRATION_DATE, 
	[STATUS]
)
VALUES
(
	@key,
	@rx,
	@pat,
	@pro,
	@drug,
	@fill,
	@dord,
	@onum,
	@ord,
	@exp,
	@stat
)
