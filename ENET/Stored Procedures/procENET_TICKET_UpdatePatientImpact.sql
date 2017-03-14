create PROCEDURE [dbo].[procENET_TICKET_UpdatePatientImpact]
(
	@tik int,
	@uby int,
	@pi bit
)
AS
UPDATE TICKET SET
	PatientImpact = @pi,
	UpdatedBy = @uby,
	UpdatedDate = getdate()
WHERE TicketId = @tik;


