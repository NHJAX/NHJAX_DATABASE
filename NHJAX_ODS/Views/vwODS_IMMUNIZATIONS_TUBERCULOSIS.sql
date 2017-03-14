




CREATE VIEW [dbo].[vwODS_IMMUNIZATIONS_TUBERCULOSIS]  
AS

SELECT	DISTINCT			PAT.PatientId	
					,PAT.FULLNAME
					,PAT.ODSLNAME
					,PAT.ODSFNAME
					,PAT.SSN
					,PAT.DOB
					,PP.PROCEDUREDATETIME AS 'APPTDATE'
					,PE.REASONFORAPPOINTMENT AS 'APPTDESC'
					,PP.CPTID
					,CPT.CPTCODE
					,ED.DIAGNOSISID
					,DX.DIAGNOSISCODE
					--,COUNT_BIG(*) AS MYCOUNT
					
		 
FROM				DBO.PATIENT PAT LEFT JOIN
					DBO.PATIENT_ENCOUNTER PE ON PE.PATIENTID = PAT.PATIENTID LEFT JOIN
					DBO.PATIENT_PROCEDURE PP ON PP.PATIENTENCOUNTERID = PE.PATIENTENCOUNTERID LEFT JOIN
					DBO.CPT CPT ON CPT.CPTID = PP.CPTID LEFT JOIN
					DBO.ENCOUNTER_DIAGNOSIS ED ON PE.PATIENTENCOUNTERID = ED.PATIENTENCOUNTERID LEFT JOIN
					DBO.DIAGNOSIS DX ON DX.DIAGNOSISID = ED.DIAGNOSISID

WHERE				(PP.CPTID IN (8580)
OR					ED.DIAGNOSISID IN (7116,12218))
OR					(ED.DIAGNOSISID in (7487,14480))
OR					(PE.ReasonForAppointment LIKE '%tst%')
OR					(PE.ReasonforAppointment like '%tb converter%')

--GROUP BY			PAT.PatientId
--					,PAT.FULLNAME
--					,PAT.ODSLNAME
--					,PAT.ODSFNAME
--					,PAT.SSN
--					,PAT.DOB
--					,PP.PROCEDUREDATETIME					
--					,PP.CPTID
--					,CPT.CPTCODE
--					,ED.DIAGNOSISID
--					,DX.DIAGNOSISCODE
--					,PE.PatientEncounterId
--					  ,PE.[PatientAppointmentKey]
--					  ,PE.[EncounterKey]
--					  ,PE.[PatientId]
--					  ,PE.[AppointmentDateTime]
--					  ,PE.[HospitalLocationId]
--					  ,PE.[ProviderId]
--					  ,PE.[Duration]
--					  ,PE.[AppointmentStatusId]
--					  ,PE.[ReasonForAppointment]
--					  ,PE.[PatientDispositionId]
--					  ,PE.[AppointmentTypeId]
--					  ,PE.[ReferralId]
--					  ,PE.[AdmissionDateTime]
--					  ,PE.[DischargeDateTime]
--					  ,PE.[CreatedDate]
--					  ,PE.[UpdatedDate]
--					  ,PE.[DateAppointmentMade]
--					  ,PE.[AccessToCareId]
--					  ,PE.[AccessToCareDate]
--					  ,PE.[PriorityId]
--					  ,PE.[SourceSystemId]
--					  ,PE.[ArrivalCategoryId]
--					  ,PE.[ReasonSeenId]
--					  ,PE.[ReleaseConditionId]
--					  ,PE.[ReleaseDateTime]
--					  ,PE.[MeprsCodeId]
--					  ,PE.[IsNonCount]
--					  ,PE.[CDMAppointmentId]
--					  ,PE.[DMISId]
--					  ,PE.[SourceSystemKey]
--					  ,PP.[ProcedureId]
--					  ,PP.[ProcedureKey]
--					  ,PP.[CptId]
--					  ,PP.[PatientEncounterId]
--					  ,PP.[ProcedureTypeId]
--					  ,PP.[DiagnosisPriorities]
--					  ,PP.[ProcedureDateTime]
--					  ,PP.[SurgeonId]
--					  ,PP.[AnesthetistId]
--					  ,PP.[ProcedureDesc]
--					  ,PP.[CreatedDate]
--					  ,PP.[UpdatedDate]
--					  ,PP.[RVU]
--					  ,PP.[SourceSystemId]
--					  ,PAT.[PatientId]
--					  ,PAT.[PatientKey]
--					  ,PAT.[NedPatientIEN]
--					  ,PAT.[FullName]
--					  ,PAT.[Sex]
--					  ,PAT.[DOB]
--					  ,PAT.[SSN]
--					  ,PAT.[StreetAddress1]
--					  ,PAT.[StreetAddress2]
--					  ,PAT.[StreetAddress3]
--					  ,PAT.[City]
--					  ,PAT.[StateId]
--					  ,PAT.[ZipCode]
--					  ,PAT.[Phone]
--					  ,PAT.[OfficePhone]
--					  ,PAT.[LastBranchOfServiceId]
--					  ,PAT.[SponsorSSN]
--					  ,PAT.[FamilyMemberPrefixId]
--					  ,PAT.[MilitaryGradeRankId]
--					  ,PAT.[DeersEligibilityEndDate]
--					  ,PAT.[AlternateCareValueId]
--					  ,PAT.[DMISId]
--					  ,PAT.[CurrentPCMId]
--					  ,PAT.[RaceId]
--					  ,PAT.[PatientAge]
--					  ,PAT.[MaritalStatusId]
--					  ,PAT.[NedLName]
--					  ,PAT.[NedFName]
--					  ,PAT.[NedMName]
--					  ,PAT.[CreatedDate]
--					  ,PAT.[UpdatedDate]
--					  ,PAT.[DisplayAge]
--					  ,PAT.[PseudoPatientId]
--					  ,PAT.[ActiveDuty]
--					  ,PAT.[PatientCategoryId]
--					  ,PAT.[PatientCoverageId]
--					  ,PAT.[RegistrationIncomplete]
--					  ,PAT.[RecordLocationId]
--					  ,PAT.[BenefitsCategoryId]
--					  ,PAT.[PharmacyComment]
--					  ,PAT.[LatexAllergy]
--					  ,PAT.[ValidateDate]
--					  ,PAT.[SourceSystemId]
--					  ,PAT.[SourceSystemKey]
--					  ,PAT.[ODSFName]
--					  ,PAT.[ODSMName]
--					  ,PAT.[ODSLName]
--					  ,PAT.[NDIEligibility]
--					  ,PAT.[HCDPCoverageId]
--					  ,CPT.[CptId]
--					  ,CPT.[CptHcpcsKey]
--					  ,CPT.[CptCode]
--					  ,CPT.[CptDesc]
--					  ,CPT.[CptTypeId]
--					  ,CPT.[RVU]
--					  ,CPT.[CMACUnit]
--					  ,CPT.[CreatedDate]
--					  ,CPT.[UpdatedDate]
--					  ,DX.[DiagnosisId]
--					  ,DX.[DiagnosisKey]
--					  ,DX.[DiagnosisCode]
--					  ,DX.[DiagnosisDesc]
--					  ,DX.[DiagnosisName]
--					  ,DX.[DiagnosisType]
--					  ,DX.[RelativeWeight]
--					  ,DX.[CreatedDate]
--					  ,DX.[UpdatedDate]
--					  ,ED.[EncounterDiagnosisId]
--					  ,ED.[PatientEncounterId]
--					  ,ED.[DiagnosisId]
--					  ,ED.[Priority]
--					  ,ED.[Description]
--					  ,ED.[CreatedDate]
--					  ,ED.[UpdatedDate]
--					  ,ED.[SourceSystemId]


