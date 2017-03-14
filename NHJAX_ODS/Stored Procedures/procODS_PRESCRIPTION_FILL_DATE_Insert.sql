
CREATE PROCEDURE [dbo].[procODS_PRESCRIPTION_FILL_DATE_Insert]
(
	@pred bigint,
	@fill datetime = '1/1/1776',
	@sup numeric(10,3),
	@pre bigint
)
AS
	SET NOCOUNT ON;
	
INSERT INTO NHJAX_ODS.dbo.PRESCRIPTION_FILL_DATE
(
	PrescriptionDrugId,
	FillDate,
	DaysSupply,
	PrescriptionId)
	VALUES(@pred,@fill,@sup,@pre
);
SELECT SCOPE_IDENTITY();
