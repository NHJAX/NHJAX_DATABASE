
create PROCEDURE [dbo].[procETL_20120815_UPDATED_OVERNIGHT_ETL_RUNS_BELOW]  AS

--Update Indexes
Declare @Old bigint
Declare @New bigint
Declare @Diff Numeric(15,4)
Declare @Msg Varchar(200)


