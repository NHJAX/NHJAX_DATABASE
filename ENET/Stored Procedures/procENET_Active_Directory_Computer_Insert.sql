create PROCEDURE [dbo].[procENET_Active_Directory_Computer_Insert]
(
	@cn varchar(50), 
	@os varchar(50), 
	@ossp varchar(50),
	@last datetime,
	@osv varchar(50),
	@dns varchar(50),
	@loc varchar(50),
	@dist varchar(255)
)
 AS

INSERT INTO ACTIVE_DIRECTORY_COMPUTER
(
	CommonName,
	operatingSystem,
	operatingSystemServicePack,
	lastLogon,
	OperatingSystemVersion,
	DNSHostName,
	Location,
	distinguishedName
)
VALUES
(
	@cn, 
	@os,
	@ossp,
	@last,
	@osv,
	@dns,
	@loc,
	@dist
)
SELECT SCOPE_IDENTITY();


