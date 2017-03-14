CREATE PROCEDURE [dbo].[procCIAO_CHECK_OUT_Insert]
(
@usr int, 
@codate datetime,
@term datetime,
@iscr bit,
@imm bit,
@tloc varchar(50),
@rea int,
@surr varchar(150),
@stat int,
@cby int,
@nts varchar(4000) = ''
)
 AS

INSERT INTO CHECK_OUT
(
UserId,
CheckOutDate,
TerminalLeaveEnds,
IsCredentialed,
ImmediateCheckOut,
TransferringLocation,
CheckOutReasonId,
Surrogate,
CheckOutStatusId,
CreatedBy,
UpdatedBy,
Notes
) 
VALUES(
@usr, 
@codate,
@term,
@iscr,
@imm,
@tloc,
@rea,
@surr,
@stat,
@cby,
@cby,
@nts
);



