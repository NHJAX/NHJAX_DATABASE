CREATE PROCEDURE [dbo].[upAssetUpdateDisposition]

(
	@disp		int,
	@remark	varchar(1000),
	@uby		int,
	@pre		varchar(50) = '',
	@num		varchar(50) = '',
	@ser		varchar(50) = '',
	@bar		varchar(50) = '',
	@debug	bit = 0
)
 AS

DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)

SELECT @sql = 'UPDATE ASSET SET
			DispositionId = @disp,
			Remarks = @remark,
			UpdatedDate = getdate(),
			UpdatedBy = @uby
		WHERE DispositionId IN (SELECT DispositionId FROM DISPOSITION WHERE ViewLevelId IN (1,2)) '

IF DataLength(@num) > 0
	SELECT @sql = @sql + 'AND PlantAccountPrefix = @pre AND PlantAccountNumber = @num '

IF DataLength(@ser) > 0
	SELECT @sql = @sql + 'AND SerialNumber = @ser '

IF DataLength(@bar) > 0
	SELECT @sql = @sql + 'AND EqpMgtBarCode = @bar '

IF @debug = 1
	PRINT @sql
	PRINT @num
	PRINT @ser
	PRINT @bar

SELECT @paramlist = 	'@disp int,
			@remark varchar(1000),
			@uby int,
			@pre varchar(50),
			@num varchar(50),
			@ser varchar(50),
			@bar varchar(50) '

EXEC sp_executesql	@sql, @paramlist, @disp, @remark, @uby, @pre, @num, @ser, @bar
