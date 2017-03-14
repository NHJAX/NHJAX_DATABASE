
create PROCEDURE [dbo].[procODS_CHCS_USER_Insert]
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
INSERT INTO NHJAX_ODS.dbo.CHCS_USER
(
	CHCSUserKey,
	CHCSUserName,
	ProviderId,
	TerminationDate,
	SSN,
	LastSignOn
) 
VALUES
(
	@usr, 
	@name,
	@pro,
	@tdate,
	@ssn,
	@sigdt
);
SELECT SCOPE_IDENTITY();
END
ELSE --Without date - null value
BEGIN
INSERT INTO NHJAX_ODS.dbo.CHCS_USER
(
	CHCSUserKey,
	CHCSUserName,
	ProviderId,
	SSN,
	LastSignOn
) 
VALUES
(
	@usr, 
	@name,
	@pro,
	@ssn,
	@sigdt
);
SELECT SCOPE_IDENTITY();
END
