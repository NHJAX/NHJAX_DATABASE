
CREATE PROCEDURE [dbo].[upENet_AssetSelectbyMacArray] 
    @strmac TEXT 
AS 
    DECLARE @XMLDoc INT 
    EXEC sp_xml_preparedocument @XMLDoc OUTPUT, @strmac
     SELECT  ASSET_MAC.AssetId, ASSET_MAC.MacAddress
     FROM OPENXML (@XMLDoc , '/ROOT/Array', 1 ) 
        WITH (Value varchar(50)) AS TempArray 
        INNER JOIN ASSET_MAC ON ASSET_MAC.MacAddress = TempArray.Value
     --EXEC sp_xml_removedocument @XMLDoc

