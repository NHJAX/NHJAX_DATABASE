CREATE PROCEDURE [dbo].[procENET_TECHNICIAN_UpdateExtended]
(
@usr int,
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
@uby int,
@inac bit,
@ssn varchar(11),
@rnk int,
@aud bigint,
@dob datetime,
@rate varchar(15),
@med varchar(20),
@oth varchar(50),
@eaos datetime,
@sex varchar(1),
@cit int,
@src int,
@nmci varchar(100),
@add1 varchar(100),
@add2 varchar(100),
@city varchar(50),
@state varchar(2),
@zip varchar(11),
@des int,
@prev varchar(50),
@ee datetime,
@cont varchar(50),
@cnum varchar(50),
@hcs int,
@bas bit,
@net bit,
@out bit,
@eth int,
@displ varchar(150),
@cidt datetime,
@sufx varchar(6) = '',
@comp int = 0,
@supe varchar(150) = '',
@edu int = 0,
@dod nvarchar(10) = '',
@eff datetime = '1/1/1776',
@emp int = 0
)
 AS

UPDATE TECHNICIAN
SET
UFName = @fname, 
ULName = @lname, 
UMName = @mname, 
Title = @title, 
EMailAddress = RTRIM(LTRIM(@email)), 
Location = @loc, 
UPhone = @ph,
Extension = @ext, 
Comments = @comm, 
UPager = @pager,
AltPhone = @alt, 
LoginId = @login, 
UpdatedBy = @uby,
UpdatedDate = getdate(),
Inactive = @inac,
SSN = @ssn,
RankId = @rnk,
AudienceId = @aud,
DOB = @dob,
Rate = @rate,
MedStuYr = @med,
OtherStu = @oth,
EAOS_PRD = @eaos,
Sex = @sex,
CitizenshipId = @cit,
SourceSystemId = @src,
NMCIEMail = @nmci,
Address1 = @add1,
Address2 = @add2,
City = @city,
[State] = @state,
Zip = @zip,
DesignationId = @des,
PreviousDutyStation = @prev,
ExpectedEndDate = @ee,
ContractorCompany = @cont,
ContractNumber = @cnum,
HealthcareStatusId = @hcs,
BaseId = @bas,
NetworkAccess = @net,
OutlookExchange = @out,
EthnicityId = @eth,
DisplayName = @displ,
CheckInDate = @cidt,
Suffix = @sufx,
ComponentId = @comp,
Supervisor = @supe,
EducationLevelId = @edu,
DoDEDI = @dod,
EffectiveDate = @eff,
EmployeeNumber = @emp
WHERE UserId = @usr;
 
 
























