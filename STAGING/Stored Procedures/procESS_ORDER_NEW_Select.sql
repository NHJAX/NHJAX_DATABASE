CREATE PROCEDURE [dbo].[procESS_ORDER_NEW_Select]
(
	@dord datetime,
	@ess bigint
)
AS
	SET NOCOUNT ON;
SELECT     
	PatientKey,
	EssPatientKey,
	OrderTime,
	StartTime,
	StopTime,
	OrderName,
	SetName,
	ProviderName,
	CategoryName,
	OrderTypeName,
	Priority,
	VerbalOrder,
	ChainId,
	OrderComments
FROM ESS_ORDER_NEW
WHERE (OrderTime = @dord
	AND EssPatientKey = @ess)
