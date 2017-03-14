CREATE PROCEDURE [dbo].[procENET_CreateSprintRegression] 
(
	@sdate 		datetime = '8/1/2007',
	@edate 		datetime = '7/31/2008',
	@sys		int = 267,
	@sess		varchar(50) = 'xyz'
)

AS
SET NOCOUNT ON;

DECLARE @sc	bigint
DECLARE @tot decimal(18,2)
DECLARE @hrs decimal(18,2)
DECLARE @act decimal(18,2)
DECLARE @reg decimal(18,2)
DECLARE @com decimal(18,2)
DECLARE @cnt int
DECLARE @est decimal(18,2)
DECLARE @chk int
DECLARE @cng decimal(18,2)
DECLARE @prev decimal(18,2)
DECLARE @cng2 decimal(18,2)
DECLARE @prev2 decimal(18,2)
--DECLARE @yr		int

--DELETE ANY CURRENT SESSION DATA
BEGIN

DELETE FROM DM_SPRINT_REGRESSION
WHERE SessionKey = @sess
OR CreatedDate < dbo.startofday(DATEADD(d,-3,getdate())) 

SET @cnt = 0
SET @tot = 0
SET @hrs = 0
SET @com = 0
SET @act = 0
SET @reg = 0
SET @cng = 0
SET @prev = 0
SET @cng2 = 0
SET @prev2 = 0

--CREATE REGRESSION CURSOR
DECLARE curREG CURSOR FAST_FORWARD FOR
SELECT DISTINCT 
	SprintCycleId
FROM dbo.vwENET_SPRINT_CYCLE
WHERE BeginDate >= @sdate
	AND EndDate < @edate

OPEN curREG

FETCH NEXT FROM curREG INTO @sc
if(@@FETCH_STATUS = 0)
	BEGIN

		WHILE(@@FETCH_STATUS = 0)
		BEGIN
			BEGIN TRANSACTION

				INSERT INTO DM_SPRINT_REGRESSION
				(
					SprintCycleId,
					SessionKey
				)
				VALUES
				(
					@sc,
					@sess
				)	
			COMMIT

			--Add Regression Stats
			SET @cnt = @cnt + 1
			SET @chk = 0

			PRINT @cnt
			--PRINT @sc
			--PRINT @sys
			IF @cnt = 1
				BEGIN
					SELECT @chk = COUNT(TotalEstimatedHours)
					FROM vwENET_BurndownTotalHoursbySprint
					WHERE SprintCycleId <= @sc
					AND SystemNameId = @sys
					
					IF @chk = 0 
						SET @tot = 0
					ELSE
						BEGIN
							SELECT @tot = SUM(TotalEstimatedHours)
							FROM vwENET_BurndownTotalHoursbySprint
							WHERE SprintCycleId <= @sc
							AND SystemNameId = @sys
						END
					
					--Hours Remaining
				
					SELECT @chk = COUNT(OpenEstimatedHours)
					FROM vwENET_BurndownOpenEstimatedSprint
					WHERE SprintCycleId <= @sc
					AND SystemNameId = @sys
					--PRINT @chk
					IF @chk = 0 
						SET @hrs = 0
					ELSE
						BEGIN
							SELECT @hrs = SUM(OpenEstimatedHours)
							FROM vwENET_BurndownOpenEstimatedSprint
							WHERE SprintCycleId <= @sc
							AND SystemNameId = @sys
						END

					UPDATE DM_SPRINT_REGRESSION
					SET SprintHoursRemaining = @hrs
					WHERE SprintCycleId = @sc
					AND SessionKey = @sess

					--Calculate Change
					SET @prev = @hrs
					UPDATE DM_SPRINT_REGRESSION
					SET EstimatedHoursChange = 0
					WHERE SprintCycleId = @sc
					AND SessionKey = @sess

					--Hours Completed
				
					SELECT @chk = COUNT(CompleteEstimatedHours)
					FROM vwENET_BurndownCompleteEstimatedSprint
					WHERE SprintCycleId <= @sc
					AND SystemNameId = @sys
					
					IF @chk = 0 
						SET @com = 0
					ELSE
						BEGIN
							SELECT @com = SUM(CompleteEstimatedHours)
							FROM vwENET_BurndownCompleteEstimatedSprint
							WHERE SprintCycleId <= @sc
							AND SystemNameId = @sys
						END

					UPDATE DM_SPRINT_REGRESSION
					SET SprintHoursCompleted = @com
					WHERE SprintCycleId = @sc
					AND SessionKey = @sess

					--Calculate Completed Change
					SET @prev2 = @com
					UPDATE DM_SPRINT_REGRESSION
					SET CompletedHoursChange = 0
					WHERE SprintCycleId = @sc
					AND SessionKey = @sess

					--PRINT @sc
					--PRINT 'COM: ' + CAST(@com as varchar(50))
					--PRINT 'PREV2: ' + CAST(@prev2 as varchar(50))
					--PRINT 'CNG2: ' + CAST(@cng2 as varchar(50))

					--Actual Hours
				
					SELECT @chk = COUNT(ActualHours)
					FROM vwENET_BurndownActualHoursSprint
					WHERE SprintCycleId <= @sc
					AND SystemNameId = @sys
					
					IF @chk = 0 
						SET @act = 0
					ELSE
						BEGIN
							SELECT @act = SUM(ActualHours)
							FROM vwENET_BurndownActualHoursSprint
							WHERE SprintCycleId <= @sc
							AND SystemNameId = @sys
						END

					UPDATE DM_SPRINT_REGRESSION
					SET SprintActualHours = @act
					WHERE SprintCycleId = @sc
					AND SessionKey = @sess
				
				END
			ELSE
				BEGIN
					SELECT @chk = COUNT(TotalEstimatedHours)
					FROM vwENET_BurndownTotalHoursbySprint
					WHERE SprintCycleId = @sc
					AND SystemNameId = @sys
					
					IF @chk = 0 
						SET @est = 0
					ELSE
						BEGIN
							SELECT @est = SUM(TotalEstimatedHours)
							FROM vwENET_BurndownTotalHoursbySprint
							WHERE SprintCycleId = @sc
							AND SystemNameId = @sys
						END
					SET @tot = @tot + @est

					--Hours Remaining
					SELECT @chk = COUNT(OpenEstimatedHours)
					FROM vwENET_BurndownOpenEstimatedSprint
					WHERE SprintCycleId = @sc
					AND SystemNameId = @sys
					

					IF @chk = 0 
						SET @est = 0
					ELSE
						BEGIN
							SELECT @est = SUM(OpenEstimatedHours)
							FROM vwENET_BurndownOpenEstimatedSprint
							WHERE SprintCycleId = @sc
							AND SystemNameId = @sys
						END
					
					SET @hrs = @hrs + @est
					
					SET @cng = @hrs - @prev
					SET @prev = @hrs

					UPDATE DM_SPRINT_REGRESSION
					SET SprintHoursRemaining = @est
					WHERE SprintCycleId = @sc
					AND SessionKey = @sess

					
					--Calculate Change
						
					UPDATE DM_SPRINT_REGRESSION
					SET EstimatedHoursChange = @cng
					WHERE SprintCycleId = @sc
					AND SessionKey = @sess

					--Hours Completed
					SELECT @chk = COUNT(CompleteEstimatedHours)
					FROM vwENET_BurndownCompleteEstimatedSprint
					WHERE SprintCycleId = @sc
					AND SystemNameId = @sys
									

					IF @chk = 0 
						SET @est = 0
					ELSE
						BEGIN
							SELECT @est = SUM(CompleteEstimatedHours)
							FROM vwENET_BurndownCompleteEstimatedSprint
							WHERE SprintCycleId = @sc
							AND SystemNameId = @sys
						END
					
					SET @com = @com + @est
					
					SET @cng2 = @com - @prev2
					SET @prev2 = @com

					UPDATE DM_SPRINT_REGRESSION
					SET SprintHoursCompleted = @est
					WHERE SprintCycleId = @sc
					AND SessionKey = @sess

					--Calculate Completed Change
						
					UPDATE DM_SPRINT_REGRESSION
					SET CompletedHoursChange = @cng2
					WHERE SprintCycleId = @sc
					AND SessionKey = @sess

					--PRINT @sc
					--PRINT 'COM: ' + CAST(@com as varchar(50))
					--PRINT 'PREV2: ' + CAST(@prev2 as varchar(50))
					--PRINT 'CNG2: ' + CAST(@cng2 as varchar(50))

					--Actual Hours
					SELECT @chk = COUNT(ActualHours)
					FROM vwENET_BurndownActualHoursSprint
					WHERE SprintCycleId = @sc
					AND SystemNameId = @sys
					
					IF @chk = 0 
						SET @est = 0
					ELSE
						BEGIN
							SELECT @est = SUM(ActualHours)
							FROM vwENET_BurndownActualHoursSprint
							WHERE SprintCycleId = @sc
							AND SystemNameId = @sys
						END
					SET @act = @act + @est

					UPDATE DM_SPRINT_REGRESSION
					SET SprintActualHours = @est
					WHERE SprintCycleId = @sc
					AND SessionKey = @sess

				END
			
			PRINT ''

			UPDATE DM_SPRINT_REGRESSION
			SET EstimatedHours = @tot
			WHERE SprintCycleId = @sc
			AND SessionKey = @sess

			UPDATE DM_SPRINT_REGRESSION
			SET HoursRemaining = @hrs
			WHERE SprintCycleId = @sc
			AND SessionKey = @sess

			UPDATE DM_SPRINT_REGRESSION
			SET HoursCompleted = @com
			WHERE SprintCycleId = @sc
			AND SessionKey = @sess

			UPDATE DM_SPRINT_REGRESSION
			SET ActualHours = @act
			WHERE SprintCycleId = @sc
			AND SessionKey = @sess

			UPDATE DM_SPRINT_REGRESSION
			SET Gap = @hrs - @act
			WHERE SprintCycleId = @sc
			AND SessionKey = @sess

			FETCH NEXT FROM curREG INTO @sc
		END
	END

CLOSE curREG
DEALLOCATE curREG

--Add trend analysis
DECLARE @max int
DECLARE @maxtot decimal(18,2)
DECLARE @maxest decimal(18,2)
DECLARE @maxcom decimal(18,2)
DECLARE @maxact decimal(18,2)
DECLARE @avgest decimal(18,2)
DECLARE @avgcom decimal(18,2)
DECLARE @avgact decimal(18,2)

DECLARE @trow int

SET @max = 0
SET @avgest = 0
SET @avgcom = 0
SET @avgact = 0

SELECT @max = MAX(SprintCycleId)
FROM DM_SPRINT_REGRESSION
WHERE SessionKey = @sess

SELECT @maxtot = EstimatedHours
FROM DM_SPRINT_REGRESSION
WHERE SprintCycleId = @max
AND SessionKey = @sess

SELECT @maxest = HoursRemaining
FROM DM_SPRINT_REGRESSION
WHERE SprintCycleId = @max
AND SessionKey = @sess

SELECT @maxcom = HoursCompleted
FROM DM_SPRINT_REGRESSION
WHERE SprintCycleId = @max
AND SessionKey = @sess

SELECT @maxact = ActualHours
FROM DM_SPRINT_REGRESSION
WHERE SprintCycleId = @max
AND SessionKey = @sess

SELECT @avgest = AVG(EstimatedHoursChange)
FROM DM_SPRINT_REGRESSION
WHERE SessionKey = @sess

SELECT @avgcom = AVG(CompletedHoursChange)
FROM DM_SPRINT_REGRESSION
WHERE SessionKey = @sess

If @avgcom <= 0
	BEGIN
		SELECT @avgcom = AVG(CompletedHoursChange)
		FROM DM_SPRINT_REGRESSION
		WHERE SessionKey = @sess
	END

If @avgcom <= 0
	BEGIN
		SET @avgcom = 5
	END

SELECT @avgact = AVG(SprintActualHours)
FROM DM_SPRINT_REGRESSION
WHERE SessionKey = @sess

SET @trow = @max + 1

WHILE @trow <= @max + 12
	BEGIN

		BEGIN TRANSACTION
			INSERT INTO DM_SPRINT_REGRESSION
			(
				SprintCycleId,
				SessionKey
			)
			VALUES
			(
				@trow,
				@sess
			)	
		COMMIT

		--SET @maxtot = @maxtot + @avgest
		UPDATE DM_SPRINT_REGRESSION
		SET EstimatedHours = @maxtot
		WHERE SessionKey = @sess
		AND SprintCycleId = @trow
				
		SET @maxact = @maxact + @avgact
		UPDATE DM_SPRINT_REGRESSION
		SET ActualHours = @maxact
		WHERE SessionKey = @sess
		AND SprintCycleId = @trow

		SET @maxcom = @maxcom + @avgcom
		UPDATE DM_SPRINT_REGRESSION
		SET HoursCompleted = @maxcom
		WHERE SessionKey = @sess
		AND SprintCycleId = @trow

		--SET @maxest = @maxest + @avgest
		UPDATE DM_SPRINT_REGRESSION
		SET HoursRemaining = @maxest - @avgcom
		WHERE SessionKey = @sess
		AND SprintCycleId = @trow

		UPDATE DM_SPRINT_REGRESSION
		SET Gap = HoursRemaining - ActualHours
		WHERE SessionKey = @sess
		AND SprintCycleId = @trow

		SET @trow = @trow + 1

	END


END

