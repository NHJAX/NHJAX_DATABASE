
create PROCEDURE [dbo].[procODS_CHCS_USER_Update_20100521]
(
	@usr numeric(12,4),
	@name varchar(30),
	@pro bigint,
	@tdate datetime,
	@ssn varchar(30),
	@sigdt varchar(17)
)
AS
	SET NOCOUNT ON;

IF @tdate > '1/1/1776'
BEGIN	
UPDATE CHCS_USER
SET CHCSUserName = @name,
	ProviderId = @pro,
	TerminationDate = @tdate,
	SSN = @ssn,
	LastSignOn = @sigdt,
	UpdatedDate = Getdate()
WHERE CHCSUserKey = @usr;
END
ELSE
BEGIN
UPDATE CHCS_USER
SET CHCSUserName = @name,
	ProviderId = @pro,
	TerminationDate = null,
	SSN = @ssn,
	LastSignOn = @sigdt,
	UpdatedDate = Getdate()
WHERE CHCSUserKey = @usr;
END

