create PROCEDURE [dbo].[upCheckOut20120723]
(
	@SSN		varchar(11),
	@Date		datetime
	
)
WITH RECOMPILE 
AS

/* update check out date in CHKMASTER table */
UPDATE CHKMASTER SET chkoutdate=@Date WHERE ssn=@SSN 

/* update checked out in ScheduledToCheckOut table */
UPDATE ScheduledToCheckOut SET CheckedOut=GETDATE() WHERE ssn=@SSN
