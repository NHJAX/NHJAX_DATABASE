
create PROCEDURE [dbo].[procODS_RELEASE_CONDITION_Insert]
(
	@desc varchar(30)
)
AS
	SET NOCOUNT ON;
	
INSERT INTO RELEASE_CONDITION
(
	ReleaseConditionDesc
) 
VALUES
(
	@desc
);
SELECT SCOPE_IDENTITY();
