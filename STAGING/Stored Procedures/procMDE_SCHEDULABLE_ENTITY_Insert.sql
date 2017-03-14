﻿CREATE PROCEDURE [dbo].[procMDE_SCHEDULABLE_ENTITY_Insert]
(
	@key numeric(14,3),
	@en varchar(30)
)
AS
	SET NOCOUNT ON;
INSERT INTO SCHEDULABLE_ENTITY
(  
	KEY_SITE,   
	KEY_SCHEDULABLE_ENTITY, 
	[ENTITY_NAME]
)
VALUES
(
	0,
	@key,
	@en
)
