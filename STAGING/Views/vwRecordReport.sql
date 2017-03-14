﻿CREATE VIEW [dbo].[vwRecordReport]
AS
	SELECT	TOP 100 PERCENT
		CURRENT_BORROWER_FILE_ROOM AS Doctor, 
		dbo.ToRecordGroup(SUM(DAYS_CHARGED_TO_BORROWER)) AS [Group]
	FROM	vwRecords
	GROUP BY CURRENT_BORROWER_FILE_ROOM
	ORDER BY CURRENT_BORROWER_FILE_ROOM, [Group]
