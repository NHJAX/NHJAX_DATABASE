CREATE PROCEDURE [dbo].[procCP_PHARMACY_CREATETABLE_CONTROLLED_SUBSTANCES_RXS]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
DECLARE @start datetime
SET @start = DATEADD(DAY, -732 , GETDATE())
	
IF (OBJECT_ID('DM_PHARMACY_CONTROLLED_SUBSTANCES_RXS') IS NOT NULL)
BEGIN
	DROP TABLE DM_PHARMACY_CONTROLLED_SUBSTANCES_RXS 
END

CREATE TABLE [dbo].[DM_PHARMACY_CONTROLLED_SUBSTANCES_RXS](
	[PrescriptionId] [bigint] PRIMARY KEY NOT NULL,
	[RXNumber] [varchar](20) NULL,
	[DrugId] [bigint] NULL,	
	[DrugDesc] [varchar](41) NULL,
	[SourceSystemId] [int] NULL,
	[DrugScheduleCode] [varchar](1) NULL,
	[PatientId] [bigint] NULL,
	[PatientName] [varchar](100) NULL,
	[SSN] [varchar](30) NULL,
	[DisplayAge] [varchar](5) NULL,
	[BenefitsCategoryId] [bigint] NULL,
	[ProviderId] [bigint] NULL,
	[LastFillDate] [datetime] NULL,
	[RefillsRemaining] [numeric](8, 3) NULL,
	[Refills] [numeric](8, 3) NULL,
	[DaysSupply] [int] NULL,
	[Quantity] [int] NULL,
	[Comments] [varchar](80) NULL,
	[Sig] [varchar](220) NULL,
	[Sig1] [varchar](28) NULL,
	[Sig2] [varchar](28) NULL,
	[Sig3] [varchar](29) NULL,
	[PharmacyId] [bigint] NULL,
	[PharmacyDesc] [varchar](50) NULL
) ON [PRIMARY]
;

DECLARE @drug bigint
DECLARE @pre bigint
DECLARE @rx varchar(20)
DECLARE @desc varchar(41)
DECLARE @src int
DECLARE @sch varchar(1)
DECLARE @pat bigint
DECLARE @name varchar(100)
DECLARE @ssn varchar(30)
DECLARE @age varchar(5)
DECLARE @ben bigint
DECLARE @pro bigint
DECLARE @last datetime
DECLARE @remain numeric(8,3)
DECLARE @refills numeric (8,3)
DECLARE @days int
DECLARE @qty int
DECLARE @cmts varchar(80)
DECLARE @sig varchar(220)
DECLARE @sig1 varchar(28)
DECLARE @sig2 varchar(28)
DECLARE @sig3 varchar(29)
DECLARE @pharmid bigint
DECLARE @pharmdesc varchar(50)

DECLARE curHU CURSOR FAST_FORWARD FOR
SELECT				  PRE.PrescriptionId
					, PRE.RXNumber
					, DRUG.DrugId
					, DRUG.DrugDesc
					, DRUG.SourceSystemId
					, DRUG.DrugScheduleCode
					, PAT.PatientId
					, PAT.FULLNAME
					, PAT.SSN
					, PAT.DisplayAge
					, PAT.BenefitsCategoryId
					, PCM.ProviderId
					, dbo.startofday(PRE.LastFillDate) as LastFillDate
					, PRE.RefillsRemaining
					, PRE.Refills
					, PRE.DaysSupply
					, PRE.Quantity
					, PRE.Comments
					, PRE.Sig
					, PRE.Sig1
					, PRE.Sig2
					, PRE.Sig3
					, PRE.PharmacyId
					, PHARMACY.PharmacyDesc
FROM				PATIENT PAT RIGHT JOIN
                    PRESCRIPTION PRE ON PAT.PatientId = PRE.PatientId LEFT JOIN
                    DRUG ON PRE.DrugId = DRUG.DrugId LEFT JOIN
                    PRIMARY_CARE_MANAGER PCM ON PAT.PatientId = PCM.PatientID LEFT JOIN
                    PHARMACY ON PRE.PharmacyId = PHARMACY.PharmacyId 
WHERE				DRUG.DRUGSCHEDULECODE IN ('2','3','4')
AND					PRE.LastFillDate > @start
ORDER BY			DRUG.DrugDesc
					,PAT.FullName

OPEN curHU
FETCH NEXT FROM cuRHU INTO @pre,@rx,@drug,@desc,@src,@sch,@pat,@name,@ssn,@age,@ben,@pro,@last,@remain,@refills,@days,@qty,@cmts,@sig,@sig1,@sig2,@sig3,@pharmid,@pharmdesc

IF (@@FETCH_STATUS = 0)
BEGIN
	WHILE (@@FETCH_STATUS = 0)
		BEGIN
			BEGIN TRANSACTION
				INSERT INTO DM_PHARMACY_CONTROLLED_SUBSTANCES_RXS
					VALUES
					(
					@pre,@rx,@drug,@desc,@src,@sch,@pat,@name,@ssn,@age,@ben,@pro,@last,@remain,@refills,@days,@qty,@cmts,@sig,@sig1,@sig2,@sig3,
					@pharmid,@pharmdesc);					
			
FETCH NEXT FROM cuRHU INTO @pre,@rx,@drug,@desc,@src,@sch,@pat,@name,@ssn,@age,@ben,@pro,@last,@remain,@refills,@days,@qty,@cmts,@sig,@sig1,@sig2,@sig3,@pharmid,@pharmdesc
			COMMIT 
		END
END

CLOSE curHU
DEALLOCATE curHU

IF (OBJECT_ID('IX_DM_CONTROLLED_SUBSTANCES_DrugId_PatientId') IS NOT NULL)
BEGIN
	DROP INDEX IX_DM_CONTROLLED_SUBSTANCES_DrugId_PatientId ON DM_PHARMACY_CONTROLLED_SUBSTANCES_RXS
END
CREATE INDEX IX_DM_CONTROLLED_SUBSTANCES_DrugId_PatientId ON
	DM_PHARMACY_CONTROLLED_SUBSTANCES_RXS(
		DRUGID, PATIENTID, PRESCRIPTIONID);
END