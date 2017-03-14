
create PROCEDURE [dbo].[procCIAO_CHECKOUT_REASON_Select]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT CheckOutReasonId,
	CheckOutReasonDesc,
	Inactive,
	CreatedDate
FROM CHECKOUT_REASON
WHERE Inactive = 0 
	AND CheckoutReasonId > 0

END

