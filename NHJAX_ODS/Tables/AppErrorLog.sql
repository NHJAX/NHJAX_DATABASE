CREATE TABLE [dbo].[AppErrorLog] (
    [Err_Number]    INT            NULL,
    [Err_Severity]  INT            NULL,
    [Err_State]     INT            NULL,
    [Err_Procedure] NVARCHAR (MAX) NULL,
    [Err_Line]      INT            NULL,
    [Err_Message]   NVARCHAR (MAX) NULL,
    [Err_DateTime]  DATETIME       CONSTRAINT [DF_AppErrorLog_Err_DateTime] DEFAULT (getdate()) NULL
);

