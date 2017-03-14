CREATE PROCEDURE [dbo].[procODS_MATERNITY_PATIENT_SelectByMatPatientId]
@MaternityPatientId int = 0
WITH EXEC AS CALLER
AS
		SELECT 
    			MPAT.MaternityPatientId,																--0
    			MPAT.PatientId,																			--1
    			PAT.FullName,																			--2
    			FMP.FamilyMemberPrefixCode,																--3
    			PAT.SponsorSSN,																			--4
    			FMP.FamilyMemberPrefixCode + '/' + RIGHT(PAT.SponsorSSN,4) as MPCSSN,					--5
    			CONVERT(NVARCHAR(10),PAT.DOB,101) as DOB ,												--6
    			PAT.StreetAddress1,																		--7
    			PAT.StreetAddress2,																		--8
    			PAT.StreetAddress3,																		--9
    			PAT.City,																				--10
    			PAT.ZipCode,																			--11
    			LOC.GeographicLocationAbbrev,															--12
    			PAT.Phone,																				--13
    			PAT.OfficePhone,																		--14
    			MPAT.EDC,																				--15
    			CONVERT(NVARCHAR(10),MPAT.EDC,101) as DISPLAYEDC ,										--16
    			DATEPART(month,MPAT.EDC) as DueMonth,													--17
    			DATEPART(Year,MPAT.EDC) as DueYear,														--18
    			MPAT.MaternityStatusId,																	--19
    			STAT.MaternityStatusDesc,																--20
    			MPAT.Notes,																				--21
    			PRO.ProviderId,																			--22
    			PRO.ProviderName,																		--23
    			PRO.ProviderCode,																		--24
    			MPAT.CreatedDate,																		--25
    			MPAT.UpdatedDate,																		--26
    			MPAT.CreatedBy,																			--27
    			MPAT.UpdatedBy,																			--28
    			PAT.DisplayAge,																			--29
    			MPAT.MaternityTeamId,																	--30
    			TEAM.MaternityTeamDesc,																	--31
    			MPAT.FPProviderId,																		--32
    			FPPRO.ProviderName as FPProviderName,													--33
    			ISNULL(TECH.ULName + ', ' + TECH.UFNAME + ' ' + TECH.UMNAME, 'System') AS AlphaName,	--34
    			ISNULL(DMIS.FacilityName, 'N/A') as Location,											--35
    			ISNULL(DMIS_PCM.FacilityName, 'N/A') as ENRDMIS,										--36
    			UIC.UICCode,																			--37
          dbo.PatientsGestationalDiabetesResults(MPAT.PatientId) as GXml,								--38
          dbo.IsGestationalDiabeticAbnormal(MPAT.PatientId) as IsAbnormal								--39
    		FROM PROVIDER AS PRO 
    			INNER JOIN PRIMARY_CARE_MANAGER AS PCM 
    			ON PRO.ProviderId = PCM.ProviderId 
    			RIGHT OUTER JOIN MATERNITY_PATIENT AS MPAT 
    			INNER JOIN PATIENT AS PAT 
    			ON MPAT.PatientId = PAT.PatientId 
    			LEFT OUTER JOIN FAMILY_MEMBER_PREFIX AS FMP 
    			ON PAT.FamilyMemberPrefixId = FMP.FamilyMemberPrefixId 
    			LEFT OUTER JOIN GEOGRAPHIC_LOCATION AS LOC 
    			ON PAT.StateId = LOC.GeographicLocationId 
    			ON PCM.PatientID = PAT.PatientId
    			INNER JOIN MATERNITY_STATUS AS STAT
    			ON MPAT.MaternityStatusId = STAT.MaternityStatusId
    			INNER JOIN MATERNITY_TEAM AS TEAM
    			ON MPAT.MaternityTeamId = TEAM.MaternityTeamId
    			INNER JOIN PROVIDER AS FPPRO
    			ON MPAT.FPProviderId = FPPRO.ENetId
    			INNER JOIN vwENET_TECHNICIAN AS TECH
    			ON MPAT.UpdatedBy = TECH.UserId
    			LEFT OUTER JOIN DMIS 
    			ON PAT.DMISId = DMIS.DMISId
    			LEFT OUTER JOIN DMIS AS DMIS_PCM
    			ON PCM.DmisId = DMIS_PCM.DMISId
    			LEFT OUTER JOIN UIC
    			ON PAT.UICId = UIC.UICId
    		WHERE MPAT.MaternityPatientId = @MaternityPatientId