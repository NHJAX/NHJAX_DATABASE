

CREATE PROCEDURE [dbo].[procENET_sessCurrentDMHRSiPositions_Insert]
(
	@org varchar(255),
    @nam varchar(255),
    @st varchar(255),
    @svc varchar(255),
    @uic varchar(255),
    @bil varchar(255),
    @titl varchar(255),
    @blk varchar(255),
    @rnk varchar(255),
    @mtyp varchar(255),
    @dmhr varchar(255),
    @hir varchar(255),
    @bin varchar(255),
    @job varchar(255),
    @cby int
)
AS
BEGIN
	
	SET NOCOUNT ON;

    INSERT INTO sessCurrentDMHRSiPositions
		(
		OrganizationName, 
		OfficialPositionName, 
		PositionStartDate, 
		PositionService, 
		PositionUic, 
		PositionBillet, 
		PositionTitle, 
		Blank, 
		PositionRank, 
		PositionManpowerType, 
		DMHRSiPositionNumber, 
        HiringStatus, 
        BIN, 
        PositionJob, 
		CreatedBy
		)
	VALUES
		(
		@org,
		@nam,
		@st,
		@svc,
		@uic,
		@bil,
		@titl,
		@blk,
		@rnk,
		@mtyp,
		@dmhr,
		@hir,
		@bin,
		@job,
		@cby 
		)
END


