
CREATE PROCEDURE [dbo].[procODS_HOSPITAL_LOCATION_Insert]
(
	@name varchar(31),
	@meprs bigint,
	@src bigint,
	@ph varchar(15),
	@key decimal(12,4) = 0,
	@div bigint = 0
)
AS
	SET NOCOUNT ON;
	
INSERT INTO NHJAX_ODS.dbo.HOSPITAL_LOCATION
(
	HospitalLocationName, 
	HospitalLocationDesc,
	MeprsCodeId,
	SourceSystemId,
	GroupPhone,
	HospitalLocationKey,
	MedicalCenterDivisionId
) 
VALUES
(
	@name, 
	@name,
	@meprs,
	@src,
	@ph,
	@key,
	@div
);
SELECT SCOPE_IDENTITY();
