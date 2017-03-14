
create PROCEDURE [dbo].[procODS_DRUG_SelectbyDesc]
(
	@desc varchar(41)
)
AS
	SET NOCOUNT ON;
SELECT     
	DrugId,
	DrugDesc
FROM DRUG
WHERE (DrugDesc = @desc)
