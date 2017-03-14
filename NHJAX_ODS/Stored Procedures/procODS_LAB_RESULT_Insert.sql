
create PROCEDURE [dbo].[procODS_LAB_RESULT_Insert]
(
	@pat bigint,
	@lab bigint,
	@ord bigint,
	@loc bigint,
	@tdate datetime,
	@edate datetime,
	@cdate datetime,
	@res varchar(19),
	@key numeric(13,3),
	@atyp bigint,
	@sub numeric(26,9),
	@ss int,
	@alrt varchar(5)
)
AS
	SET NOCOUNT ON;
	
INSERT INTO NHJAX_ODS.dbo.LAB_RESULT
(
	PatientId, 
	LabTestId, 
	OrderId, 
	LabWorkElementId, 
	TakenDate, 
	EnterDate, 
	CertifyDate, 
	Result, 
	LabResultKey, 
    AccessionTypeId, 
    LabResultSubKey, 
    SourceSystemId, 
    Alert
) 
VALUES
(
	@pat,
	@lab,
	@ord,
	@loc,
	@tdate,
	@edate,
	@cdate,
	@res,
	@key,
	@atyp,
	@sub,
	@ss,
	@alrt
);
SELECT SCOPE_IDENTITY();