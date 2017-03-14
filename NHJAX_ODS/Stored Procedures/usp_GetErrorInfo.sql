
-- Create procedure to retrieve error information.
CREATE PROCEDURE [dbo].[usp_GetErrorInfo]
AS
INSERT INTO [NHJAX_ODS].[dbo].[AppErrorLog]
           ([Err_Number]
           ,[Err_Severity]
           ,[Err_State]
           ,[Err_Procedure]
           ,[Err_Line]
           ,[Err_Message])
SELECT
    ERROR_NUMBER() AS ErrorNumber
    ,ERROR_SEVERITY() AS ErrorSeverity
    ,ERROR_STATE() AS ErrorState
    ,ERROR_PROCEDURE() AS ErrorProcedure
    ,ERROR_LINE() AS ErrorLine
    ,ERROR_MESSAGE() AS ErrorMessage;
