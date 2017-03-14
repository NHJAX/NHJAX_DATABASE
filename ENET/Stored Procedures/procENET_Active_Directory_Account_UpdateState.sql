create PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdateState]
(
@st varchar(2), 
@log varchar(50)
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET [State] = @st,
LastReportedDate = getdate()
WHERE LoginId = @log;



