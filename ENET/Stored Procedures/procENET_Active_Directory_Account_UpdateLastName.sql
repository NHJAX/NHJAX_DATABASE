﻿create PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdateLastName]
(
@lname varchar(50), 
@log varchar(50)
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET LastName = @lname,
LastReportedDate = getdate()
WHERE LoginId = @log;



