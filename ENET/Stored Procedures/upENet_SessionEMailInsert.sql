CREATE PROCEDURE [dbo].[upENet_SessionEMailInsert]
(
	@to varchar(4000),
	@cc varchar(4000),
	@bcc varchar(4000),
	@cby int
)
AS
	BEGIN TRANSACTION
	
	INSERT INTO sessEMail
	(
	ToList,
	CcList,
	BccList,
	Createdby
	)
	VALUES
	(
	@to,
	@cc,
	@bcc,
	@cby
	);
	COMMIT TRANSACTION

