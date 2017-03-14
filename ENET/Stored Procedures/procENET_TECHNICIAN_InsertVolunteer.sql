﻿CREATE PROCEDURE [dbo].[procENET_TECHNICIAN_InsertVolunteer]
(
@fname varchar(50), 
@lname varchar(50), 
@mname varchar(50), 
@ph varchar(50)= '', 
@ext varchar(10),
@comm varchar(8000), 
@pager varchar(50),
@alt varchar(50), 
@login varchar(256),
@cby int,
@ssn varchar(11),
@aud bigint,
@dob datetime,
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
@hcs int,
@bas int,
@eth int,
@cidt datetime,
@sufx varchar(6) = '',
@comp int = 0,
@edu int = 0,
@pre varchar(10) = ''
)
 AS
SET ARITHABORT ON;
INSERT INTO TECHNICIAN
(
UFName, 
ULName, 
UMName,  
UPhone, 
Extension, 
Comments, 
UPager,
AltPhone, 
LoginId,
CreatedBy, 
SSN,
AudienceId,
DOB,
Sex,
CitizenshipId,
SourceSystemId,
NMCIEMail,
Address1,
Address2,
City,
[State],
Zip,
DesignationId,
HealthcareStatusId,
BaseId,
EthnicityId,
CheckInDate,
Suffix,
ComponentId,
EducationLevelId,
Prefix
) 
VALUES
(
@fname, 
@lname, 
@mname, 
@ph, 
@ext,
@comm, 
@pager,
@alt, 
@login,
@cby,
@ssn,
@aud,
@dob,
@sex,
@cit,
@src,
@nmci,
@add1,
@add2,
@city,
@state,
@zip,
@des,
@hcs,
@bas,
@eth,
@cidt,
@sufx,
@comp,
@edu,
@pre
);
SELECT SCOPE_IDENTITY();

SET ARITHABORT OFF;
