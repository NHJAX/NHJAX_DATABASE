CREATE PROCEDURE [dbo].[procCIO_CheckOut_Insert]
(
@usr int, 
@codate datetime,
@rt nvarchar(50),
@sp nvarchar(50),
@sres nvarchar(50),
@stat int,
@cby int,
@odate datetime = '1/1/1776',
@tdate datetime = '1/1/1776',
@rdate datetime = '1/1/1776',
@list int = 0,
@dmlss bit = 0
)
 AS

INSERT INTO CheckOut
(
UserId,
dtChkOut,
txtReturn,
txtSurrTele,
txtSurrResults,
StatusId,
CreatedBy,
OfficialDate,
TransferDate,
RetirementDate,
CheckListId,
HasDMLSS
) 
VALUES(
@usr, 
@codate,
@rt,
@sp,
@sres,
@stat,
@cby,
@odate,
@tdate,
@rdate,
@list,
@dmlss
);



