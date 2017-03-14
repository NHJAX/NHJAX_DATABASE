create PROCEDURE [dbo].[procENET_Audience_Insert]
(
@desc varchar(50), 
@code varchar(20), 
@cby int, 
@inac bit 
)
 AS

INSERT INTO AUDIENCE
(
	AudienceDesc, 
	OrgChartCode, 
	CreatedBy, 
	Inactive
)
VALUES(@desc, @code, @cby, @inac)
SELECT SCOPE_IDENTITY();


