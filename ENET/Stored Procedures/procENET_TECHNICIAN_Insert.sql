CREATE PROCEDURE [dbo].[procENET_TECHNICIAN_Insert]
(
@fname varchar(50), 
@lname varchar(50), 
@mname varchar(50), 
@title varchar(50), 
@email varchar(250), 
@aud bigint, 
@loc varchar(100), 
@ph varchar(50), 
@ext varchar(10),
@pager varchar(50), 
@comm varchar(8000), 
@alt varchar(50), 
@login varchar(256),
@inactive bit, 
@cby int, 
@ssn varchar(11),
@dod nvarchar(10)
)
 AS
SET ARITHABORT ON;
INSERT INTO TECHNICIAN
(
UFName, 
ULName, 
UMName, 
Title, 
EMailAddress, 
AudienceId, 
Location, 
UPhone, 
Extension, 
UPager, 
Comments, 
AltPhone, 
LoginId, 
Inactive, 
CreatedBy, 
SSN,
DoDEDI
) 
VALUES(
@fname, 
@lname, 
@mname, 
@title, 
RTRIM(LTRIM(@email)), 
@aud, 
@loc, 
@ph, 
@ext,
@pager, 
@comm, 
@alt, 
@login,
@inactive, 
@cby, 
@ssn,
@dod
);
SELECT SCOPE_IDENTITY();
SET ARITHABORT OFF;


