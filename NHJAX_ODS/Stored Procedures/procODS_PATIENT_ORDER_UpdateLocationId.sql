
create PROCEDURE [dbo].[procODS_PATIENT_ORDER_UpdateLocationId]
(
	@id bigint,
	@loc bigint
)
AS
	SET NOCOUNT ON;
UPDATE PATIENT_ORDER
SET LocationId = @loc,
UpdatedDate = GETDATE()
WHERE (OrderId = @id)


