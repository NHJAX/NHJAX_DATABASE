CREATE PROCEDURE [dbo].[procAAP_TECHNICIAN_Insert]
(
@pfx varchar(10),
@fname varchar(50), 
@lname varchar(50), 
@mname varchar(50), 
@sfx varchar(6), 
@rnk int,
@rate varchar(50),
@email varchar(250), 
@dob datetime, 
@sex varchar(1),
@ssn varchar(11), 
@ph varchar(50), 
@cit int,
@eth int, 
@eaos datetime,
@comm varchar(8000),  
@cby int
)
 AS
SET ARITHABORT ON;
INSERT INTO TECHNICIAN
(
Prefix,
UFName, 
ULName, 
UMName, 
Suffix,
RankId,
Rate,
NMCIEMail, 
DOB, 
Sex, 
SSN, 
UPhone, 
CitizenshipId, 
EthnicityId,
EAOS_PRD,
Comments,  
CreatedBy, 
AudienceId,
LoginId,
SourceSystemId,
DesignationId,
BaseId,
DoNotDisplay,
IsAIMException
) 
VALUES(
@pfx,
@fname, 
@lname, 
@mname,
@sfx, 
@rnk, 
@rate,
@email, 
@dob, 
@sex, 
@ssn, 
@ph,
@cit, 
@eth,
@eaos,
@comm, 
@cby, 
420,
@fname + @lname,
5,
5,
0,
1,
1
);
SELECT SCOPE_IDENTITY();
SET ARITHABORT OFF;


