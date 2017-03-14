


CREATE PROCEDURE [dbo].[procENET_ACTIVE_DIRECTORY_ACCOUNT_UpdateAll] 
AS
BEGIN

DECLARE @lrdate datetime
DECLARE @stat int
DECLARE @id varchar(50)
DECLARE @lng varchar(150)
DECLARE @log varchar(50)
DECLARE @exp datetime
DECLARE @logd varchar(50)
DECLARE @inac bit
DECLARE @cdate datetime
DECLARE @udate datetime
DECLARE @adid bigint
DECLARE @svc bit
DECLARE @ssn varchar(11)
DECLARE @hid bit
DECLARE @dod nvarchar(10)

DECLARE @idX int
DECLARE @ssnX varchar(11)
DECLARE @dodX nvarchar(10)

Declare @exists int

EXEC dbo.upLog 'Begin ADA Update';

	DECLARE curADA CURSOR FAST_FORWARD FOR
	SELECT     
		LastReportedDate, 
		ENetStatus, 
		EmployeeId, 
		LongUserName, 
		LoginID, 
		ADExpiresDate, 
		ADLoginDate, 
		Inactive, 
		CreatedDate, 
		UpdatedDate, 
		ActiveDirectoryAccountId, 
        ServiceAccount, 
        ISNULL(SSN,''), 
        IsHidden, 
        ISNULL(DoDEDI,'')
	FROM ACTIVE_DIRECTORY_ACCOUNT
	WHERE ((ENetStatus = 1) AND (EmployeeId = ''))
		OR ((ENetStatus = 0) 
			AND DATEDIFF(DAY,LastReportedDate,GETDATE()) > 30)
		OR ((ENetStatus = 2))
		OR ((EmployeeId = ''))

	OPEN curADA
	
	FETCH NEXT FROM curADA INTO @lrdate,@stat,@id,@lng,@log,@exp,
		@logd,@inac,@cdate,@udate,@adid,@svc,@ssn,@hid,@dod

	if(@@FETCH_STATUS = 0)

	BEGIN

		WHILE(@@FETCH_STATUS = 0)
		BEGIN
			IF(@id = '') --All blank accounts
				BEGIN
					SET @idX = ''
					SELECT @idX = ISNULL(UserId,'')
					FROM TECHNICIAN
					WHERE LoginId = @log
					
					IF(@idX <> '')
					BEGIN
						UPDATE ACTIVE_DIRECTORY_ACCOUNT
						SET EmployeeId = @idX
						WHERE LoginID = @log
					END
				END
			
			IF(@ssn = '') --All blank accounts
				BEGIN
					SET @ssnX = ''
					SELECT @ssnX = ISNULL(SSN,'')
					FROM TECHNICIAN
					WHERE LoginId = @log
					
					IF(@ssnX <> '')
					BEGIN
						UPDATE ACTIVE_DIRECTORY_ACCOUNT
						SET SSN = @ssnX
						WHERE LoginID = @log
					END
				END
				
			IF(@dod = '') --All blank accounts
				BEGIN
					SET @dodX = ''
					SELECT dodX = ISNULL(DoDEDI,'')
					FROM TECHNICIAN
					WHERE LoginId = @log
					
					IF(@dodX <> '')
					BEGIN
						UPDATE ACTIVE_DIRECTORY_ACCOUNT
						SET DoDEDI = @dodX
						WHERE LoginID = @log
					END
				END
		
			IF(@stat = 0)
			BEGIN
				IF DATEDIFF(DAY,@lrdate,GETDATE()) > 30 AND @svc = 0
				BEGIN
					UPDATE ACTIVE_DIRECTORY_ACCOUNT
					SET Inactive = 1,
						ENetStatus = 1
					WHERE LoginID = @log
					
					UPDATE TECHNICIAN
					SET Inactive = 1
					WHERE LoginID = @log
					
				END
			END
			
			IF(@stat = 2 AND @id <> '')
			BEGIN
				IF DATEDIFF(DAY,@lrdate,GETDATE()) > 30 AND @svc = 0
				BEGIN
					UPDATE TECHNICIAN
					SET Inactive = 1,
					UpdatedDate = GETDATE()
					WHERE LoginID = @log
					
					UPDATE ACTIVE_DIRECTORY_ACCOUNT
					SET Inactive = 1,
						ENetStatus = 1
					WHERE LoginID = @log
				END
				ELSE
				BEGIN
					UPDATE TECHNICIAN
					SET Inactive = 0,
					UpdatedDate = GETDATE()
					WHERE LoginID = @log
					
					UPDATE ACTIVE_DIRECTORY_ACCOUNT
					SET Inactive = 0,
						ENetStatus = 0
					WHERE LoginID = @log
				END
			END

			FETCH NEXT FROM curADA INTO @lrdate,@stat,@id,@lng,@log,@exp,
				@logd,@inac,@cdate,@udate,@adid,@svc,@ssn,@hid,@dod

		END
	END

	CLOSE curADA
	DEALLOCATE curADA

	EXEC dbo.upLog 'End ADA Update';

END






