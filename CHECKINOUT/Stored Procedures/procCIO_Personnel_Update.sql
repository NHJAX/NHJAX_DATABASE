CREATE PROCEDURE [dbo].[procCIO_Personnel_Update]
(
@pers bigint,
@fname varchar(50), 
@lname varchar(50), 
@mname varchar(50), 
@title varchar(50), 
@email varchar(100), 
@loc varchar(100), 
@ph varchar(50), 
@ext varchar(10),
@comm varchar(8000), 
@pager varchar(50),
@alt varchar(50), 
@login varchar(256),
@ssn varchar(11),
@rnk int,
@rate varchar(15),
@aud bigint,
@dob datetime,
@med varchar(20),
@oth varchar(50),
@nmci varchar(100),
@cit int,
@uby int,
@eaos datetime,
@sex varchar(1),
@acc varchar(20),
@ver varchar(20),
@add1 varchar(100),
@add2 varchar(100),
@city varchar(50),
@state varchar(2),
@zip varchar(11),
@des int,
@net bit,
@out bit,
@prev varchar(50),
@ee datetime,
@cont varchar(50),
@cnum varchar(50),
@hcs int,
@eth int,
@bas int,
@ahlta varchar(20),
@displ varchar(150),
@cidt datetime,
@sufx varchar(6) = '',
@comp int = 0,
@supe varchar(150) = '',
@edu int = 0,
@dod bigint = 0,
@eff datetime = '1/1/1776',
@emp int = 0,
@npi numeric(16,3) = 0
)
 AS

UPDATE PERSONNEL
SET
FirstName = @fname, 
LastName = @lname, 
MiddleName = @mname, 
Title = @title, 
EMailAddress = @email, 
Location = @loc, 
UPhone = @ph,
Extension = @ext, 
Comments = @comm, 
UPager = @pager,
AltPhone = @alt, 
LoginId = @login, 
SSN = @ssn,
RankId = @rnk,
Rate = @rate,
AudienceId = @aud,
DOB = @dob,
MedStuYr = @med,
OtherStu = @oth,
NMCIEMail = @nmci,
CitizenshipId = @cit,
UpdatedBy = @uby,
UpdatedDate = getdate(),
EAOS_PRD = @eaos,
Sex = @sex,
ACCESSCODE = @acc,
VERIFYCODE = @ver,
Address1 = @add1,
Address2 = @add2,
City = @city,
[State] = @state,
Zip = @zip,
DesignationId = @des,
NetworkAccess = @net,
OutlookExchange = @out,
PreviousDutyStation = @prev,
ExpectedEndDate = @ee,
ContractorCompany = @cont,
ContractNumber = @cnum,
HealthcareStatusId = @hcs,
EthnicityId = @eth,
BaseId = @bas,
AHLTA = @ahlta,
DisplayName = @displ,
CheckInDate = @cidt,
Suffix = @sufx,
ComponentId = @comp,
Supervisor = @supe,
EducationLevelId = @edu,
DoDEDI = @dod,
EffectiveDate = @eff,
EmployeeNumber = @emp,
NPIKey = @npi
WHERE PersonnelId = @pers;
 
 
























