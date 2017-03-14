
-- =============================================
-- Author:		K. Sean Kern
-- Create date: 2015-04-01
-- Description:	Insert from Essentris
-- =============================================

create PROCEDURE [dbo].[procESS_ORDER_NEW_Insert]
(
	@pat bigint,
	@epat bigint,
	@dord datetime,
	@start datetime,
	@stop datetime,
	@ord nvarchar(500),
	@set nvarchar(500),
	@pro nvarchar(255),
	@cat nvarchar(50),
	@typ nvarchar(50),
	@pri nvarchar(50),
	@verb int,
	@chn int,
	@comm nvarchar(1000)
)
AS

INSERT INTO ESS_ORDER_NEW
(
	PatientKey,
	EssPatientKey,
	OrderTime,
	StartTime,
	StopTime,
	OrderName,
	SetName,
	ProviderName,
	CategoryName,
	OrderTypeName,
	Priority,
	VerbalOrder,
	ChainId,
	OrderComments
)
VALUES
(
	@pat,
	@epat,
	@dord,
	@start,
	@stop,
	@ord,
	@set,
	@pro,
	@cat,
	@typ,
	@pri,
	@verb,
	@chn,
	@comm
)



