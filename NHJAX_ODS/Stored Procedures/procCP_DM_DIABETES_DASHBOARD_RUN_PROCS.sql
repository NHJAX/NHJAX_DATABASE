
CREATE PROCEDURE [dbo].[procCP_DM_DIABETES_DASHBOARD_RUN_PROCS]
	
AS
BEGIN
		SET NOCOUNT ON;
DECLARE @labdate as datetime
declare @encdate as datetime
DECLARE @today as datetime

set @today = DATEPART(DW,GETDATE())

--IF  (@today = 4)  --THURSDAY
BEGIN

	TRUNCATE TABLE DM_DIABETES_DASHBOARD_LAB_RESULTS_AVERAGES

	BEGIN

	EXEC dbo.upActivityLog 'Begin Diabetes A1C Dashboard Averages', 6
	EXEC dbo.procCP_DM_DIABETES_DASHBOARD_LAB_RESULT_AVERAGES 1
	EXEC dbo.upActivityLog 'End Diabetes A1C Dashboard Averages', 6

	END

	BEGIN

	EXEC dbo.upActivityLog 'Begin Diabetes GFR Dashboard Averages', 6
	EXEC dbo.procCP_DM_DIABETES_DASHBOARD_LAB_RESULT_AVERAGES 2
	EXEC dbo.upActivityLog 'End Diabetes GFR Dashboard Averages', 6	

	END

	BEGIN

	EXEC dbo.upActivityLog 'Begin Diabetes LDL Dashboard Averages', 6
	EXEC dbo.procCP_DM_DIABETES_DASHBOARD_LAB_RESULT_AVERAGES 3
	EXEC dbo.upActivityLog 'Begin Diabetes LDL Dashboard Averages', 6
	
	END

	BEGIN

	EXEC dbo.upActivityLog 'Begin Diabetes Microalbumin Dashboard Averages', 6
	EXEC dbo.procCP_DM_DIABETES_DASHBOARD_LAB_RESULT_AVERAGES 4
	EXEC dbo.upActivityLog 'End Diabetes Microalbumin Dashboard Averages', 6
	
	END

END
--RUN DIABETIC ENCOUNTERS--------------------------------------------------


--IF @today = 5 --WEDNESDAY
BEGIN

	TRUNCATE TABLE DM_DIABETES_DASHBOARD_ENCOUNTERS_PERCENTAGES

-------------------FLU SHOT------------
	BEGIN
	
	EXEC dbo.upActivityLog 'Begin Diabetes Flu Shot Dashboard Percentages', 6
	EXEC DBO.procCP_DM_DIABETES_DASHBOARD_ENCOUNTER_PERCENTAGES 1
	EXEC dbo.upActivityLog 'End Diabetes Flu Shot Dashboard Percentages', 6
	
	END

-------------------EYE EXAM------------
	BEGIN

	EXEC dbo.upActivityLog 'Begin Diabetes Eye Exam Dashboard Percentages', 6
	EXEC DBO.procCP_DM_DIABETES_DASHBOARD_ENCOUNTER_PERCENTAGES 2
	EXEC dbo.upActivityLog 'End Diabetes Eye Exam Dashboard Percentages', 6	
	END

-------------------NUTRITION CONSULT------------
	BEGIN

	EXEC dbo.upActivityLog 'Begin Diabetes Nutrition Consult Dashboard Percentages', 6	
	EXEC DBO.procCP_DM_DIABETES_DASHBOARD_ENCOUNTER_PERCENTAGES 3
	EXEC dbo.upActivityLog 'End Diabetes Nutrition Consult Dashboard Percentages', 6	

	END

-------------------FOOT EXAM------------
	BEGIN

	EXEC dbo.upActivityLog 'Begin Foot Exam Consult Dashboard Percentages', 6	
	EXEC DBO.procCP_DM_DIABETES_DASHBOARD_ENCOUNTER_PERCENTAGES 4
	EXEC dbo.upActivityLog 'End Foot Exam Consult Dashboard Percentages', 6	
	PRINT 'FOOT EXAM DONE'
	END

-------------------PNEUMOVAX------------
	BEGIN

	EXEC dbo.upActivityLog 'Begin Pneumovax Consult Dashboard Percentages', 6	
	EXEC DBO.procCP_DM_DIABETES_DASHBOARD_ENCOUNTER_PERCENTAGES 5
	EXEC dbo.upActivityLog 'End Pneumovax Consult Dashboard Percentages', 6	
	
	END
END

END
