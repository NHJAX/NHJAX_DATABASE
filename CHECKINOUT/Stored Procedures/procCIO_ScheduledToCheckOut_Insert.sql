CREATE PROCEDURE [dbo].[procCIO_ScheduledToCheckOut_Insert]
(
@ssn varchar(11),
@fname varchar(30),
@mi varchar(1),
@lname varchar(30),
@stat varchar(20),
@site int,
@chkdate datetime,
@pro bit,
@grd varchar(30),
@reason varchar(50),
@cby int,
@usr int,
@imm bit,
@off datetime,
@trn datetime,
@ret datetime,
@list int = 0,
@dod nvarchar(10) = ''
)
 AS

insert into ScheduledToCheckOut
(
	SSN,
	FirstName,
	MI,
	LastName,
	[Status],
	SiteId,
	CheckOutDate,
	IsProvider,
	Grade,
	Reason,
	CreatedBy,
	UserId,
	ImmediateCheckOut,
	OfficialDate,
	TransferDate,
	RetirementDate,
	ChecklistId,
	DoDEDI
)
values
(
	@SSN, 
	@FName, 
	@MI, 
	@LName, 
	@Stat, 
	@Site, 
	@ChkDate, 
	@Pro, 
	@grd, 
	@Reason,
	@cby,
	@usr,
	@imm,
	@off,
	@trn,
	@ret,
	@list,
	@dod
);



