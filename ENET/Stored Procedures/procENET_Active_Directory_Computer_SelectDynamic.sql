CREATE PROCEDURE [dbo].[procENET_Active_Directory_Computer_SelectDynamic]
(
	@ball bit = 0,
	@brem bit = 0,
	@bhid bit = 0,
	@disp int = -2,
	@bfil bit = 0,
	@cn varchar(50) = '',
	@debug	bit = 0,
	@breac bit = 0
)
 AS
--****
DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)

PRINT @ball
PRINT @brem
PRINT @bhid
PRINT @disp
PRINT @bfil
PRINT @cn
PRINT @debug
PRINT @breac

SELECT @sql = 'SELECT  DISTINCT   
	ADC.ActiveDirectoryComputerId, 
	ADC.CommonName, 
	ADC.operatingSystem, 
	ADC.operatingSystemServicePack, 
	ADC.lastLogon, 
	ADC.OperatingSystemVersion, 
	ADC.DNSHostName, 
	ADC.Location, 
	ADC.distinguishedName, 
	ADC.CreatedDate, 
	ADC.UpdatedDate, 
	ADC.LastReportedDate, 
	ADC.DeletedDate, 
	ISNULL(ASTD.DispositionDesc, ''Not in ENet'') AS DispositionDesc,
	ADC.Remarks,
	DATEDIFF(day,ADC.LastReportedDate,(SELECT TOP 1 LastReportedDate FROM dbo.vwENET_ACTIVE_DIRECTORY_COMPUTER_LastReportedDate)) AS LastReportedDays,
	ISNULL(ASTD.DispositionId, -1) AS DispositionId,
	ADC.IsHidden
FROM vwENET_ASSET_DISPOSITION AS ASTD 
	RIGHT OUTER JOIN ACTIVE_DIRECTORY_COMPUTER AS ADC 
	ON ASTD.NetworkName = ADC.CommonName
WHERE     (1 = 1) '

IF @ball = 0
BEGIN
	IF @bfil = 0
		BEGIN
			IF @disp = -2
			BEGIN
				SELECT @sql = @sql + 'AND (ASTD.DispositionId NOT IN (0,1,14,15,19) OR ASTD.DispositionId IS NULL) '

				IF @cn <> ''
				BEGIN
					SELECT @sql = @sql + 'AND ADC.CommonName LIKE ''%' + @cn + '%'' '
				END			

				IF @brem = 0 AND @breac = 0
				BEGIN
					SELECT @sql = @sql + 'AND ADC.DeletedDate < ''7/4/1776'' '
				END

				IF @bhid = 0
				BEGIN
					SELECT @sql = @sql + 'AND ADC.IsHidden = 0 '
				END
			END
			ELSE
			BEGIN
				IF @disp = -1
				BEGIN
					SELECT @sql = @sql + 'AND ASTD.DispositionId IS NULL '
				END
				ELSE
				BEGIN
					SELECT @sql = @sql + 'AND ASTD.DispositionId = @disp '
				END

				IF @cn <> ''
				BEGIN
					SELECT @sql = @sql + 'AND ADC.CommonName LIKE ''%' + @cn + '%'' '
				END			

				IF @brem = 0 AND @breac = 0
				BEGIN
					SELECT @sql = @sql + 'AND ADC.DeletedDate < ''7/4/1776'' '
				END
				
				IF @bhid = 0
				BEGIN
					SELECT @sql = @sql + 'AND ADC.IsHidden = 0 '
				END
			END
		END
	ELSE
		BEGIN
			IF @bhid = 1
			BEGIN
				IF @cn = ''
				BEGIN
					SELECT @sql = @sql + 'AND ADC.IsHidden = @bhid '
				END
				ELSE
				BEGIN
					SELECT @sql = @sql + 'AND (ADC.IsHidden = @bhid '
					SELECT @sql = @sql + 'AND ADC.CommonName LIKE ''%' + @cn + '%'') '
				END
			END
			IF @brem = 1
			BEGIN
				IF @cn = ''
				BEGIN
					SELECT @sql = @sql + 'AND ADC.DeletedDate > ''1/1/1776'' '
				END
				ELSE
				BEGIN
					SELECT @sql = @sql + 'AND (ADC.DeletedDate > ''1/1/1776'' '
					SELECT @sql = @sql + 'AND ADC.CommonName LIKE ''%' + @cn + '%'') '
				END
			END
			
			IF @breac = 1
			BEGIN
				IF @cn = ''
				BEGIN
					SELECT @sql = @sql + 'AND (ADC.DeletedDate > ''1/1/1776'' '
					SELECT @sql = @sql + 'AND (ADC.lastLogon > ADC.DeletedDate '
					SELECT @sql = @sql + 'OR ADC.LastReportedDate > ADC.DeletedDate)) '
				END
				ELSE
				BEGIN
					SELECT @sql = @sql + 'AND (ADC.DeletedDate > ''1/1/1776'' '
					SELECT @sql = @sql + 'AND ADC.CommonName LIKE ''%' + @cn + '%'' '
					SELECT @sql = @sql + 'AND (ADC.lastLogon > ADC.DeletedDate '
					SELECT @sql = @sql + 'OR ADC.LastReportedDate > ADC.DeletedDate)) '
				END
			END
			
			IF @disp > -1
			BEGIN
				IF @cn = ''
				BEGIN
					SELECT @sql = @sql + 'AND ASTD.DispositionId = @disp '
				END
				ELSE
				BEGIN
					SELECT @sql = @sql + 'AND (ASTD.DispositionId = @disp '
					SELECT @sql = @sql + 'AND ADC.CommonName LIKE ''%' + @cn + '%'') '
				END
			END
			ELSE
				IF @disp = -1
				BEGIN
					IF @cn = ''
					BEGIN
						SELECT @sql = @sql + 'AND ASTD.DispositionId IS NULL '
					END
					ELSE
					BEGIN
						SELECT @sql = @sql + 'AND (ASTD.DispositionId IS NULL '
						SELECT @sql = @sql + 'AND ADC.CommonName LIKE ''%' + @cn + '%'') '
					END
				END
		END
END


IF @debug = 1
	PRINT @sql
	

SELECT @paramlist = 	
	'@ball bit,
	@brem bit,
	@bhid bit,
	@disp int,
	@bfil bit,
	@breac bit'
			
EXEC sp_executesql	@sql, @paramlist, @ball, @brem, @bhid,
					@disp, @bfil, @breac



