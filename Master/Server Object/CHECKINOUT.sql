EXECUTE sp_addlinkedserver @server = N'CHECKINOUT'
GO
EXECUTE sp_addlinkedsrvlogin @rmtsrvname = N'CHECKINOUT'
