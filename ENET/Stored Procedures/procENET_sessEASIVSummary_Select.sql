

CREATE PROCEDURE [dbo].[procENET_sessEASIVSummary_Select]
	@proc bit
AS
BEGIN
	
	SET NOCOUNT ON;

	IF @proc = 0
	BEGIN
    SELECT     
		EASIVSummaryId, 
		DmisId, 
		[Month], 
		[Year], 
		ParentDmisId, 
		Uic, 
		Fcc, 
		Supe, 
		NationalIdentifier, 
		FullName, 
		EmployeeNumber,
		CASE ISDATE(EmpAssignStartDate) 
			WHEN 1 THEN CAST(empassignstartdate AS datetime) 
			ELSE CAST('1/1/1776' AS datetime) 
        END AS EmpAssignStartDate, 
        EmpAssignEndDate, 
        EmpAssignOrganizationName, 
        EmpAsgUic, 
        EmpAsgOrgDmisId, 
        EmpAsgParentDmisId, 
        EmpAsgFcc, 
        EmpPeopleGrpOrgName, 
        PeopleGroupOrgDmisId, 
        PeopleGroupUic, 
        PeopleGroupParentDmisId, 
        PeopleGroupFcc, 
        PeopleGroupLoanedTimeFcc, 
        PgSupe, 
        PersonTypeId, 
        [Service], 
        Grade, 
        ContractorType, 
        LocalNationalType, 
        ReserveType, 
        ForeignMilitary, 
        NonDodCivilian, 
        Country, 
        Thcsrr, 
        SkillType, 
        SkillTypeSuffix, 
        CommercialActReas, 
        Suoc, 
        ProjectType, 
        PersonnelCategory, 
        ProjectNo, 
        ProjectName, 
        TaskNumber, 
        TaskName, 
        TaskUic, 
        TaskServiceType, 
        TaskDmisId, 
        TaskFcc, 
        TaskSupe, 
        ProjectParentUic, 
        ProjectParentDmisId, 
        SourceOfFunds, 
        DutyIndicator, 
        Bsl, 
        Suee, 
        AvailSalExpSUM, 
        NonAvailSalExpSUM, 
        AvailableFteSUM, 
        NonAvailSickHospFteSUM, 
        NonAvailLeaveFteSUM, 
        NonAvailOthFteSUM, 
        AvailHoursSUM, 
        NonAvailHospSickHoursSUM, 
        NonAvailLeaveHoursSUM, 
        NonAvailOthHoursSUM, 
        CreatedDate, 
        CreatedBy
	FROM sessEASIVSummary
	WHERE IsProcessed = 0
	ORDER BY EmpAssignStartDate
	END
	ELSE
	BEGIN
	SELECT     
		EASIVSummaryId, 
		DmisId, 
		[Month], 
		[Year], 
		ParentDmisId, 
		Uic, 
		Fcc, 
		Supe, 
		NationalIdentifier, 
		FullName, 
		EmployeeNumber, 
		CASE ISDATE(EmpAssignStartDate) 
			WHEN 1 THEN CAST(empassignstartdate AS datetime) 
			ELSE CAST('1/1/1776' AS datetime) 
        END AS EmpAssignStartDate, 
        EmpAssignEndDate, 
        EmpAssignOrganizationName, 
        EmpAsgUic, 
        EmpAsgOrgDmisId, 
        EmpAsgParentDmisId, 
        EmpAsgFcc, 
        EmpPeopleGrpOrgName, 
        PeopleGroupOrgDmisId, 
        PeopleGroupUic, 
        PeopleGroupParentDmisId, 
        PeopleGroupFcc, 
        PeopleGroupLoanedTimeFcc, 
        PgSupe, 
        PersonTypeId, 
        [Service], 
        Grade, 
        ContractorType, 
        LocalNationalType, 
        ReserveType, 
        ForeignMilitary, 
        NonDodCivilian, 
        Country, 
        Thcsrr, 
        SkillType, 
        SkillTypeSuffix, 
        CommercialActReas, 
        Suoc, 
        ProjectType, 
        PersonnelCategory, 
        ProjectNo, 
        ProjectName, 
        TaskNumber, 
        TaskName, 
        TaskUic, 
        TaskServiceType, 
        TaskDmisId, 
        TaskFcc, 
        TaskSupe, 
        ProjectParentUic, 
        ProjectParentDmisId, 
        SourceOfFunds, 
        DutyIndicator, 
        Bsl, 
        Suee, 
        AvailSalExpSUM, 
        NonAvailSalExpSUM, 
        AvailableFteSUM, 
        NonAvailSickHospFteSUM, 
        NonAvailLeaveFteSUM, 
        NonAvailOthFteSUM, 
        AvailHoursSUM, 
        NonAvailHospSickHoursSUM, 
        NonAvailLeaveHoursSUM, 
        NonAvailOthHoursSUM, 
        CreatedDate, 
        CreatedBy
	FROM sessEASIVSummary
	WHERE IsProcessed = 1
	ORDER BY EmpAssignStartDate
	END
END



