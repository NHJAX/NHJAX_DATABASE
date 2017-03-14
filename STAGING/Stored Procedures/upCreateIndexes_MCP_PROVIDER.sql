create PROCEDURE [dbo].[upCreateIndexes_MCP_PROVIDER] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_MCP_PROVIDER')
		DROP INDEX MCP_PROVIDER.ind_MCP_PROVIDER
                                                                
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_MCP_PROVIDER_KEY_MCP_PROVIDER')
		DROP INDEX MCP_PROVIDER.IX_MCP_PROVIDER_KEY_MCP_PROVIDER
		                                                                
	CREATE INDEX 	IX_MCP_PROVIDER_KEY_MCP_PROVIDER
	ON 			MCP_PROVIDER(KEY_MCP_PROVIDER)
	WITH 			FILLFACTOR = 100
