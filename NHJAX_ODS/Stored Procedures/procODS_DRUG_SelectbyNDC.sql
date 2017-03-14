
create PROCEDURE [dbo].[procODS_DRUG_SelectbyNDC]
(
	@ndc varchar(15)
)
AS
	SET NOCOUNT ON;
SELECT     
	DrugId,
	DrugDesc
FROM DRUG
WHERE (NDCNumber = dbo.FormattedNDC(@ndc))
