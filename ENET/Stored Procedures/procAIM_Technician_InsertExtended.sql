﻿CREATE PROCEDURE [dbo].[procAIM_Technician_InsertExtended]
(
@fname varchar(50), 
@lname varchar(50), 
@mname varchar(50),
@sufx varchar(6),
@add1 varchar(100),
@add2 varchar(100),
@city varchar(50),
@state varchar(2),
@zip varchar(11),
@dob datetime,
@ssn varchar(11),
@sex varchar(1),
@cit int,
@eth int,
@des int,
@rnk int,
@rate varchar(15),
@bas int,
@aud bigint,
@loc varchar(100),
@ph varchar(50), 
@ext varchar(10),
@alt varchar(50),
@pager varchar(50),
@title varchar(50), 
@eaos datetime, 
@ee datetime,
@med varchar(20),
@oth varchar(50),
@nmci varchar(100),
@cont varchar(50),
@cnum varchar(50),
@hcs int,
@login varchar(256),
@cby int,
@uby int,
@src int,
@cpt int,
@cidt datetime = '1/1/1776',
@supe varchar(150) = '',
@emp int = 0,
@dod nvarchar(10) = ''
)
 AS

INSERT INTO TECHNICIAN
(
UFName, 
ULName, 
UMName,
Suffix,
Address1,
Address2,
City,
[State],
Zip,
DOB,
SSN, 
Sex,
CitizenshipId,
EthnicityId,
DesignationId,
RankId,
Rate,
BaseId,
AudienceId,
Location,
UPhone, 
Extension,
AltPhone,
UPager,
Title, 
EAOS_PRD, 
ExpectedEndDate, 
MedStuYr,
OtherStu, 
NMCIEMail, 
ContractorCompany,
ContractNumber,
HealthcareStatusId,
LoginId,
CreatedBy,
UpdatedBy,
SourceSystemId,
ComponentId,
CheckInDate,
Supervisor,
EmployeeNumber,
DoDEDI
) 
VALUES
(
@fname, 
@lname, 
@mname,
@sufx,
@add1,
@add2,
@city,
@state,
@zip,
@dob,
@ssn,
@sex,
@cit,
@eth,
@des,
@rnk,
@rate,
@bas,
@aud,
@loc,
@ph, 
@ext,
@alt,
@pager,
@title, 
@eaos, 
@ee,
@med,
@oth,
@nmci,
@cont,
@cnum,
@hcs,
@login,
@cby,
@uby,
@src,
@cpt,
@cidt,
@supe,
@emp,
@dod
);
SELECT SCOPE_IDENTITY();


