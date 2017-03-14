CREATE PROCEDURE [dbo].[procENET_ACTIVE_DIRECTORY_ACCOUNT_UpdateADA] 
AS

--ADA Fields
DECLARE @emp1 varchar(50)
DECLARE @ssn1 varchar(11)
DECLARE @long1 varchar(150)
DECLARE @log1 varchar(50)
DECLARE @dist1 varchar(255)
DECLARE @dod1 nvarchar(10)
DECLARE @stat1 int

--ENET Fields
DECLARE @ssn2 varchar(11)
DECLARE @log2 varchar(50)
DECLARE @dist2 varchar(255)
DECLARE @dod2 nvarchar(10)
DECLARE @enum2 int
DECLARE @npi2 numeric(16,3)

--CIAO Fields
DECLARE @usr3 int
DECLARE @ssn3 varchar(11)
DECLARE @log3 varchar(50)
DECLARE @dod3 nvarchar(10)
DECLARE @enum3 int
DECLARE @npi3 numeric(16,3)

--Calculated Fields
DECLARE @dod nvarchar(10)
DECLARE @usr int
DECLARE @dep bit
DECLARE @psnl bigint
DECLARE @stat int

SET @stat = -1

DECLARE curAda CURSOR LOCAL FAST_FORWARD FOR
SELECT 
	ISNULL(EmployeeID,''),
	ISNULL(SSN,''),
	LongUserName,
	LoginID,
	ISNULL(distinguishedName,''),
	ISNULL(DoDEDI,''),
	ENetStatus
FROM ACTIVE_DIRECTORY_ACCOUNT
--WHERE EmployeeID IN('12362','12122')
WHERE LastReportedDate > DATEADD(YEAR,-1,GETDATE())
AND EmployeeId <> 'UBE'

OPEN curAda

FETCH NEXT FROM curAda INTO @emp1,@ssn1,@long1,@log1,@dist1,@dod1,@stat1

if(@@FETCH_STATUS = 0)

BEGIN
BEGIN TRANSACTION
	WHILE(@@FETCH_STATUS = 0)
	BEGIN

		--DoDEDI from LongUserName in ARS
		IF IsNumeric(@long1) = 0
		BEGIN
			IF CHARINDEX('@mil', @long1) > 0 AND LEN(@long1) > 12
			BEGIN
				SET @dod = SUBSTRING(@long1,CHARINDEX('@mil', @long1)-10,10)
			END 
		END
		ELSE
		BEGIN
			SET @dod = REPLACE(@long1,'@mil','')
		END
		
		--PRINT @log1
		--PRINT 'long1'
		--PRINT @long1
		--PRINT @dod
		
		--Find UserId
		SET @usr = 0
		IF LEN(@emp1) > 1
		BEGIN
			SET @usr = CAST(@emp1 AS int)
			
			SELECT @stat = CAST(Inactive AS int)
			FROM TECHNICIAN
			WHERE UserId = @usr
		END
		ELSE
		BEGIN
			--Lookup based on other values
			SELECT @usr = UserID,
			@stat = CAST(Inactive AS int)
			FROM TECHNICIAN
			WHERE LoginId = @log1
			
			IF @usr = 0
			BEGIN
				--Try DoDEDI
				SELECT @usr = UserID,
				@stat = CAST(Inactive AS int)
				FROM TECHNICIAN
				WHERE DoDEDI = @dod
			END
		END
		
		--PRINT 'usr'
		--PRINT @usr
		

		--ENetStatus
		IF @usr = 0
		BEGIN
			SET @stat = 2
		END
		
		--PRINT 'stat'
		--PRINT @stat

		--Find PersonnelId
		SET @psnl = 0
		SELECT TOP 1 @psnl = PersonnelId
		FROM CHECKINOUT.dbo.PERSONNEL
		WHERE UserId = @usr
		ORDER BY CreatedDate DESC

		IF @psnl = 0
		BEGIN
			SELECT TOP 1 @psnl = PersonnelId
			FROM CHECKINOUT.dbo.PERSONNEL
			WHERE LoginId = @log1
			ORDER BY CreatedDate DESC
		END
		
		--PRINT 'psnl'
		--PRINT @psnl

		--Find Deployed
		IF CHARINDEX('Deployed', @dist1) > 0
		BEGIN
			SET @dep = 1
		END
		ELSE
		BEGIN
			SET @dep = 0
		END
		
		--PRINT 'dep'
		--PRINT @dep
		
		--PRINT 'log1'
		--PRINT @log1

		IF @usr > 0
		BEGIN
		--Load ENET variables
		SELECT 
			@ssn2 = TECH.SSN,
			@log2 = TECH.LoginId,
			@dist2 = ISNULL(TECH.DistinguishedName,''),
			@dod2 = ISNULL(TECH.DoDEDI,''),
			@enum2 = ISNULL(TECH.EmployeeNumber,0),
			@npi2 = ISNULL(EXT.NPIKey,0)
		FROM TECHNICIAN AS TECH
		LEFT JOIN TECHNICIAN_EXTENDED AS EXT
		ON TECH.UserId = EXT.UserId
		WHERE TECH.UserId = @usr
		END
		
		--PRINT 'ENET'
		--PRINT @ssn2
		--PRINT @log2
		--PRINT @dist2
		--PRINT @dod2
		--PRINT @enum2
		--PRINT @npi2

		IF @psnl > 0
		BEGIN
			SELECT
				@usr3 = UserId,
				@ssn3 = SSN,
				@log3 = LoginId,
				@dod3 = ISNULL(DoDEDI,''),
				@enum3 = ISNULL(EmployeeNumber,0),
				@npi3 = ISNULL(NPIKey,0)
			FROM CHECKINOUT.dbo.PERSONNEL
			WHERE PersonnelId = @psnl
		END

		--Start Updates
		--Update ADA
		IF @usr = 0
		BEGIN
			UPDATE ACTIVE_DIRECTORY_ACCOUNT
			SET ENetStatus = @stat,
			UpdatedBy = 0
			WHERE LoginId = @log1
		END
		ELSE
		BEGIN
			--Other Updates
			UPDATE ACTIVE_DIRECTORY_ACCOUNT
			SET ENetStatus = @stat,
			UpdatedBy = 0
			WHERE LoginId = @log1
			
			IF LEN(@emp1) = 0
			BEGIN
				UPDATE ACTIVE_DIRECTORY_ACCOUNT
				SET EmployeeId = CAST(@usr AS varchar(50)),
				UpdatedBy = 0
				WHERE LoginId = @log1
			END
			
			--PRINT 'dod'
			--PRINT @dod
			--PRINT 'dod1'
			--PRINT @dod1
			--PRINT 'dod2'
			--PRINT @dod2
			--PRINT @usr
			
			IF LEN(@dod1) = 0 AND LEN(@dod2) = 0
			BEGIN
				--PRINT 'DoDx'
				UPDATE ACTIVE_DIRECTORY_ACCOUNT
				SET DoDEDI = @dod,
				UpdatedBy = 0
				WHERE EmployeeId = CAST(@usr AS varchar(50))
			END
			ELSE IF LEN(@dod1) = 0 OR @dod1 <> @dod2
			BEGIN
				--PRINT 'DoDy'
				UPDATE ACTIVE_DIRECTORY_ACCOUNT
				SET DoDEDI = @dod2,
				UpdatedBy = 0
				WHERE EmployeeId = CAST(@usr AS varchar(50))
			END
			
			
			IF LEN(@ssn1) = 0 OR @ssn1 <> @ssn2
			BEGIN
				UPDATE ACTIVE_DIRECTORY_ACCOUNT
				SET SSN = @ssn2,
				UpdatedBy = 0
				WHERE EmployeeId = CAST(@usr AS varchar(50))
			END
		END

		--Update ENET
		IF @usr > 0
		BEGIN
			IF LEN(@dod1) > 0 AND @dod1 <> @dod2
			BEGIN
				UPDATE TECHNICIAN
				SET DoDEDI = @dod1,
				UpdatedBy = 0
				WHERE UserId = @usr
			END
			
			--PRINT '1'
			
			IF LEN(@dist1) > 0 AND @dist1 <> @dist2
			BEGIN
				UPDATE TECHNICIAN
				SET distinguishedName = @dist1,
				UpdatedBy = 0
				WHERE UserId = @usr
			END
		END

		--Update CIAO
		IF @psnl > 0
		BEGIN
			IF LEN(@dod1) = 0 AND LEN(@dod3) = 0
			BEGIN
				--PRINT 'DoDz'
				UPDATE CHECKINOUT.dbo.PERSONNEL
				SET DoDEDI = @dod
				WHERE PersonnelId = @psnl
			END
			ELSE
			IF LEN(@dod1) > 0 AND @dod1 <> @dod3
			BEGIN
				UPDATE CHECKINOUT.dbo.PERSONNEL
				SET DoDEDI = @dod1
				WHERE PersonnelId = @psnl
			END
			--PRINT '0'
			IF LEN(@enum2) > 0 AND @enum2 <> @enum3
			BEGIN
				UPDATE CHECKINOUT.dbo.PERSONNEL
				SET EmployeeNumber = @enum2
				WHERE PersonnelId = @psnl
			END
			
			IF LEN(@npi2) > 0 AND @npi2 <> @npi3
			BEGIN
				UPDATE CHECKINOUT.dbo.PERSONNEL
				SET NPIKey = @npi2
				WHERE PersonnelId = @psnl
			END
		END

	FETCH NEXT FROM curAda INTO @emp1,@ssn1,@long1,@log1,@dist1,@dod1,@stat1
	END
COMMIT
END


CLOSE curAda
DEALLOCATE curAda
