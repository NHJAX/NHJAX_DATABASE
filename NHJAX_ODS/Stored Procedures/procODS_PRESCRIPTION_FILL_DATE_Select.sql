
CREATE PROCEDURE [dbo].[procODS_PRESCRIPTION_FILL_DATE_Select]
(
	@pred bigint,
	@fill datetime = '1/1/1776'
)
AS
	SET NOCOUNT ON;
	
SELECT 	
	PrescriptionFillDateId,
	PrescriptionDrugId,
	ISNULL(FillDate, '1/1/1776')
	DaysSupply,
	PrescriptionId
FROM NHJAX_ODS.dbo.PRESCRIPTION_FILL_DATE
WHERE PrescriptionDrugId = @pred
	AND FillDate = @fill
