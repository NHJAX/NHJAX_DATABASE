CREATE PROCEDURE [dbo].[procENET_CreateSprintRegressionAll] 


AS
SET NOCOUNT ON;

DECLARE @sys int
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
DECLARE @sess varchar(50)

--DELETE ANY CURRENT SESSION DATA
BEGIN

SET @sess = 'abc'

DELETE FROM DM_SPRINT_REGRESSION
WHERE SessionKey = @sess
OR CreatedDate < dbo.startofday(DATEADD(d,-3,getdate())) 

--LOOP THROUGH ALL BURNDOWN ITEMS
DECLARE curSYS CURSOR FAST_FORWARD FOR
SELECT SystemId
FROM dbo.SYSTEM_TYPE
WHERE (Inactive = 0) AND (IsBurndown = 1)

OPEN curSYS

FETCH NEXT FROM curSYS INTO @sys
if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN	

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
			WHERE dbo.vwENET_SPRINT_CYCLE.BeginDate < getdate()

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
								SystemId,
								SessionKey
								
							)
							VALUES
							(
								@sc,
								@sys,
								@sess	
							)	
						COMMIT

						--Add Regression Stats
						SET @cnt = @cnt + 1
						SET @chk = 0

						--PRINT @cnt
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
								AND SystemId = @sys

								--Calculate Change
								SET @prev = @hrs
								UPDATE DM_SPRINT_REGRESSION
								SET EstimatedHoursChange = 0
								WHERE SprintCycleId = @sc
								AND SessionKey = @sess
								AND SystemId = @sys

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
								AND SystemId = @sys

								--Calculate Completed Change
								SET @prev2 = @com
								UPDATE DM_SPRINT_REGRESSION
								SET CompletedHoursChange = 0
								WHERE SprintCycleId = @sc
								AND SessionKey = @sess
								AND SystemId = @sys

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
								AND SystemId = @sys
							
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
								AND SystemId = @sys
								
								--Calculate Change
									
								UPDATE DM_SPRINT_REGRESSION
								SET EstimatedHoursChange = @cng
								WHERE SprintCycleId = @sc
								AND SessionKey = @sess
								AND SystemId = @sys

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
								AND SystemId = @sys

								--Calculate Completed Change
									
								UPDATE DM_SPRINT_REGRESSION
								SET CompletedHoursChange = @cng2
								WHERE SprintCycleId = @sc
								AND SessionKey = @sess
								AND SystemId = @sys

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
								AND SystemId = @sys

							END
						
						PRINT ''

						UPDATE DM_SPRINT_REGRESSION
						SET EstimatedHours = @tot
						WHERE SprintCycleId = @sc
						AND SessionKey = @sess
						AND SystemId = @sys

						UPDATE DM_SPRINT_REGRESSION
						SET HoursRemaining = @hrs
						WHERE SprintCycleId = @sc
						AND SessionKey = @sess
						AND SystemId = @sys

						UPDATE DM_SPRINT_REGRESSION
						SET HoursCompleted = @com
						WHERE SprintCycleId = @sc
						AND SessionKey = @sess
						AND SystemId = @sys

						UPDATE DM_SPRINT_REGRESSION
						SET ActualHours = @act
						WHERE SprintCycleId = @sc
						AND SessionKey = @sess
						AND SystemId = @sys

						UPDATE DM_SPRINT_REGRESSION
						SET Gap = @hrs - @act
						WHERE SprintCycleId = @sc
						AND SessionKey = @sess
						AND SystemId = @sys

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
			DECLARE @enddt bigint
			DECLARE @trow int
			DECLARE @remhr decimal(18,2)

			SET @max = 0
			SET @avgest = 0
			SET @avgcom = 0
			SET @avgact = 0

			SELECT @max = MAX(SprintCycleId)
			FROM DM_SPRINT_REGRESSION
			WHERE SessionKey = @sess
			AND SystemId = @sys

			SELECT @maxtot = EstimatedHours
			FROM DM_SPRINT_REGRESSION
			WHERE SprintCycleId = @max
			AND SessionKey = @sess
			AND SystemId = @sys

			SELECT @maxest = HoursRemaining
			FROM DM_SPRINT_REGRESSION
			WHERE SprintCycleId = @max
			AND SessionKey = @sess
			AND SystemId = @sys

			SELECT @maxcom = HoursCompleted
			FROM DM_SPRINT_REGRESSION
			WHERE SprintCycleId = @max
			AND SessionKey = @sess
			AND SystemId = @sys

			SELECT @maxact = ActualHours
			FROM DM_SPRINT_REGRESSION
			WHERE SprintCycleId = @max
			AND SessionKey = @sess
			AND SystemId = @sys

			SELECT @avgest = AVG(EstimatedHoursChange)
			FROM DM_SPRINT_REGRESSION
			WHERE SessionKey = @sess
			AND SystemId = @sys

			SELECT @avgcom = AVG(CompletedHoursChange)
			FROM DM_SPRINT_REGRESSION
			WHERE SessionKey = @sess
			AND SystemId = @sys

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
			AND SystemId = @sys

			SET @remhr = @maxest
			SET @trow = @max + 1

			WHILE @remhr > 0
				BEGIN

					BEGIN TRANSACTION
						INSERT INTO DM_SPRINT_REGRESSION
						(
							SprintCycleId,
							SessionKey,
							SystemId
						)
						VALUES
						(
							@trow,
							@sess,
							@sys
						)	
					COMMIT

					--SET @maxtot = @maxtot + @avgest
					UPDATE DM_SPRINT_REGRESSION
					SET EstimatedHours = @maxtot
					WHERE SessionKey = @sess
					AND SprintCycleId = @trow
					AND SystemId = @sys
							
					SET @maxact = @maxact + @avgact
					UPDATE DM_SPRINT_REGRESSION
					SET ActualHours = @maxact
					WHERE SessionKey = @sess
					AND SprintCycleId = @trow
					AND SystemId = @sys

					SET @maxcom = @maxcom + @avgcom
					UPDATE DM_SPRINT_REGRESSION
					SET HoursCompleted = @maxcom
					WHERE SessionKey = @sess
					AND SprintCycleId = @trow
					AND SystemId = @sys

					--SET @maxest = @maxest + @avgest
					UPDATE DM_SPRINT_REGRESSION
					SET HoursRemaining = @remhr
					WHERE SessionKey = @sess
					AND SprintCycleId = @trow
					AND SystemId = @sys

					UPDATE DM_SPRINT_REGRESSION
					SET Gap = HoursRemaining - ActualHours
					WHERE SessionKey = @sess
					AND SprintCycleId = @trow
					AND SystemId = @sys

					SET @trow = @trow + 1
					SET @remhr = @remhr - @avgcom
					
					--PRINT @sys
					--PRINT @trow
					--PRINT @maxtot
					--PRINT @maxcom
					--PRINT @avgcom
					--PRINT @remhr


				END				

				UPDATE DM_SPRINT_REGRESSION
				SET EndDate = @trow
				WHERE SessionKey = @sess
				AND SystemId = @sys

		FETCH NEXT FROM curSYS INTO @sys
	END
CLOSE curSYS
DEALLOCATE curSYS

END
END

