CREATE PROCEDURE [dbo].[procENET_DM_ADC_Create] 
(
	@sess	varchar(50),
	@adc	bigint,
	@cn		varchar(50),
	@os		varchar(50),
	@ossp	varchar(50),
	@last	datetime,
	@osv	varchar(50),
	@dns	varchar(50),
	@loc	varchar(50),
	@dist	varchar(255),
	@cdate	datetime,
	@udate	datetime,
	@rdate	datetime,
	@ddate	datetime,
	@desc	varchar(50),
	@rem	varchar(1000),
	@days	int,
	@disp	int,
	@bhid	bit
)

AS
SET NOCOUNT ON;

--DELETE ANY CURRENT SESSION DATA
BEGIN

INSERT INTO DM_ADC
(
	SessionKey, 
	ActiveDirectoryComputerId, 
	CommonName, 
	OperatingSystem, 
	OperatingSystemServicePack, 
	LastLogon, 
	OperatingSystemVersion, 
	DNSHostName, 
	Location, 
	distinguishedName, 
	CreatedDate, 
	UpdatedDate, 
	LastReportedDate,
	DeletedDate, 
	DispositionDesc, 
	Remarks, 
	LastReportedDays, 
	DispositionId,
	IsHidden
)
VALUES
(
	@sess,
	@adc,
	@cn,
	@os,
	@ossp,
	@last,
	@osv,
	@dns,
	@loc,
	@dist,
	@cdate,
	@udate,
	@rdate,
	@ddate,
	@desc,
	@rem,
	@days,
	@disp,
	@bhid
)

END

