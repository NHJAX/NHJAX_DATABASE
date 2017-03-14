CREATE PROCEDURE [dbo].[procCIO_Personnel_SelectCheckinbyId]
(
	@chk bigint
)
AS

UPDATE    PERSONNEL_CHECKIN
SET              
	CheckinStatusId = 3, 
	UpdatedBy = 6711, 
	UpdatedDate = GETDATE()
WHERE (CheckinStatusId = 0) 
	AND (AudienceId NOT IN (246,247)) 
	AND (DATEDIFF(d, CreatedDate, GETDATE()) > 30);

SELECT     
	CHK.PersonnelCheckinId, 
	PERS.PersonnelId, 
	PERS.LastName,
	PERS.FirstName, 
	PERS.MiddleName, 
	PERS.SSN, 
	RNK.RankAbbrev, 
	PERS.Rate, 
	DES.DesignationDesc, 
	BAS.BaseName, 
	AUD.DisplayName, 
	PERS.CreatedDate, 
	STAT.CheckInStatusId,
	STAT.CheckInStatusDesc,
	CHK.AudienceId,
	BAS.BaseId,
	PERS.Suffix,
	PERS.LB,
	PERS.PSQ,
	PERS.UserId,
	PERS.DoDEDI,
	TECH.EmployeeNumber
FROM	PERSONNEL AS PERS 
	INNER JOIN PERSONNEL_CHECKIN AS CHK 
	ON PERS.PersonnelId = CHK.PersonnelId 
	INNER JOIN vwENET_RANK AS RNK 
	ON PERS.RankId = RNK.RankId 
	INNER JOIN vwENET_AUDIENCE AS AUD 
	ON PERS.AudienceId = AUD.AudienceId 
	INNER JOIN vwENET_DESIGNATION AS DES 
	ON PERS.DesignationId = DES.DesignationId 
	INNER JOIN CHECKIN_STATUS AS STAT 
	ON CHK.CheckinStatusId = STAT.CheckInStatusId 
	INNER JOIN vwENET_BASE AS BAS 
	ON PERS.BaseId = BAS.BaseId
	LEFT OUTER JOIN vwENET_TECHNICIAN AS TECH
	ON PERS.UserId = TECH.UserId
WHERE	(CHK.PersonnelCheckinId = @chk)
ORDER BY 
	PERS.CreatedDate, 
	BAS.BaseId, 
	AUD.DisplayName







