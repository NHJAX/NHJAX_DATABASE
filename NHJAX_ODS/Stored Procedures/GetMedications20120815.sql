CREATE PROCEDURE [dbo].[GetMedications20120815] 
(
	@PatientID	bigint,
	@StartDate	smalldatetime,
	@EndDate	smalldatetime
)
WITH RECOMPILE
AS
BEGIN
select rx.PatientID, DrugDesc as Medication, OrderDateTime, prov.ProviderName as Provider from prescription rx
join drug d on rx.DrugID=d.DrugID
left outer join provider prov on rx.ProviderID=prov.ProviderID
where PatientID=@PatientID and OrderDateTime between @StartDate and @EndDate

END