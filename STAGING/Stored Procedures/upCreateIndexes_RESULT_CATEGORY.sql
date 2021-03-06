﻿CREATE PROCEDURE [dbo].[upCreateIndexes_RESULT_CATEGORY] AS
	IF EXISTS (SELECT NAME FROM SYSINDEXES WHERE NAME = 'ind_RESULT_CATEGORY')
	DROP INDEX RESULT_CATEGORY.ind_RESULT_CATEGORY

	IF EXISTS (SELECT NAME FROM SYSINDEXES WHERE NAME = 'IX_RESULT_CATEGORY_KEY_RESULT_CATEGORY')
	DROP INDEX RESULT_CATEGORY.IX_RESULT_CATEGORY_KEY_RESULT_CATEGORY

	CREATE INDEX IX_RESULT_CATEGORY_KEY_RESULT_CATEGORY
	ON		RESULT_CATEGORY(KEY_RESULT_CATEGORY)
	WITH		FILLFACTOR = 100
