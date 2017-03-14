
CREATE PROCEDURE [dbo].[procODS_DRUG_Insert]
(
	@code numeric(21,3),
	@desc varchar(41)
	
)
AS
	SET NOCOUNT ON;
	
INSERT INTO DRUG
(
	NDCNumber,
	DrugDesc,
	SourceSystemId
) 
VALUES
( 
	dbo.FormattedNDC(@code),
	@desc,
	5
);
SELECT SCOPE_IDENTITY();
