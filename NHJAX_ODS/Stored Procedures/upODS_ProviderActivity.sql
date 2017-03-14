
CREATE PROCEDURE [dbo].[upODS_ProviderActivity]
AS

DECLARE @exists int

DECLARE @pro bigint
DECLARE @proX bigint
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0
	
EXEC dbo.upActivityLog 'Begin Provider Activity',0,@day;

DECLARE curAct CURSOR FAST_FORWARD FOR
SELECT     
	PRO.ProviderId
FROM         
	PROVIDER AS PRO 
	INNER JOIN vwSTG_STG_PROVIDER_ACTIVITY AS PACT 
	ON PRO.ProviderKey = PACT.Provider_Ien

OPEN curAct

EXEC dbo.upActivityLog 'Fetch Provider Activity',0
FETCH NEXT FROM curAct INTO @pro

if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		BEGIN TRANSACTION

			Select 	@proX = ProviderId
				FROM PROVIDER_ACTIVITY
				WHERE ProviderId = @pro;
				
				SET @exists = @@RowCount
				If @exists = 0 
					BEGIN	
						INSERT INTO PROVIDER_ACTIVITY
						(
						ProviderId
						)
						VALUES
						(@pro);
					END
				else
					BEGIN
						UPDATE PROVIDER_ACTIVITY
						SET UpdatedDate = getdate()
						WHERE ProviderId = @pro;
					END
	
		FETCH NEXT FROM curAct INTO @pro
		COMMIT
	END

END
CLOSE curAct
DEALLOCATE curAct

EXEC dbo.upActivityLog 'Delete Provider Activity',0;

DELETE FROM PROVIDER_ACTIVITY
WHERE UpdatedDate < DATEADD(d,-1,getdate())

EXEC dbo.upActivityLog 'End Provider Activity',0,@day;




