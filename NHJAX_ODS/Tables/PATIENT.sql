CREATE TABLE [dbo].[PATIENT] (
    [PatientId]               BIGINT          IDENTITY (0, 1) NOT NULL,
    [PatientKey]              NUMERIC (13, 3) NULL,
    [NedPatientIEN]           NUMERIC (13, 3) NULL,
    [FullName]                VARCHAR (32)    NULL,
    [Sex]                     VARCHAR (30)    NULL,
    [DOB]                     DATETIME        NULL,
    [SSN]                     VARCHAR (30)    NULL,
    [StreetAddress1]          VARCHAR (55)    NULL,
    [StreetAddress2]          VARCHAR (36)    NULL,
    [StreetAddress3]          VARCHAR (30)    NULL,
    [City]                    VARCHAR (30)    NULL,
    [StateId]                 BIGINT          NULL,
    [ZipCode]                 VARCHAR (10)    NULL,
    [Phone]                   VARCHAR (25)    NULL,
    [OfficePhone]             VARCHAR (19)    NULL,
    [LastBranchOfServiceId]   BIGINT          CONSTRAINT [DF_PATIENT_LastBranchOfServiceId] DEFAULT ((0)) NULL,
    [SponsorSSN]              VARCHAR (15)    NULL,
    [FamilyMemberPrefixId]    BIGINT          NULL,
    [MilitaryGradeRankId]     BIGINT          CONSTRAINT [DF_PATIENT_MilitaryGradeRankId] DEFAULT ((0)) NULL,
    [DeersEligibilityEndDate] VARCHAR (30)    NULL,
    [AlternateCareValueId]    BIGINT          NULL,
    [DMISId]                  BIGINT          CONSTRAINT [DF_PATIENT_DMISId] DEFAULT ((2011)) NULL,
    [CurrentPCMId]            BIGINT          NULL,
    [RaceId]                  BIGINT          CONSTRAINT [DF_PATIENT_RaceId] DEFAULT ((4)) NULL,
    [PatientAge]              INT             NULL,
    [MaritalStatusId]         BIGINT          NULL,
    [NedLName]                VARCHAR (30)    NULL,
    [NedFName]                VARCHAR (30)    NULL,
    [NedMName]                VARCHAR (25)    NULL,
    [CreatedDate]             DATETIME        CONSTRAINT [DF_PATIENT_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]             DATETIME        CONSTRAINT [DF_PATIENT_UpdatedDate] DEFAULT (getdate()) NULL,
    [DisplayAge]              VARCHAR (15)    NULL,
    [PseudoPatientId]         INT             CONSTRAINT [DF_PATIENT_PseudoPatientId] DEFAULT ((0)) NULL,
    [ActiveDuty]              TINYINT         CONSTRAINT [DF_PATIENT_ActiveDuty] DEFAULT ((2)) NULL,
    [PatientCategoryId]       BIGINT          NULL,
    [PatientCoverageId]       BIGINT          NULL,
    [RegistrationIncomplete]  BIT             CONSTRAINT [DF_PATIENT_RegistrationComplete] DEFAULT ((0)) NULL,
    [RecordLocationId]        BIGINT          CONSTRAINT [DF_PATIENT_RecordLocationId] DEFAULT ((0)) NULL,
    [BenefitsCategoryId]      BIGINT          CONSTRAINT [DF_PATIENT_BenefitsCategoryId] DEFAULT ((0)) NULL,
    [PharmacyComment]         VARCHAR (62)    NULL,
    [LatexAllergy]            BIT             CONSTRAINT [DF_PATIENT_LatexAllergy] DEFAULT ((0)) NULL,
    [ValidateDate]            DATETIME        CONSTRAINT [DF_PATIENT_ValidateDate] DEFAULT (getdate()) NULL,
    [SourceSystemId]          INT             CONSTRAINT [DF_PATIENT_SourceSystemId] DEFAULT ((2)) NULL,
    [SourceSystemKey]         VARCHAR (50)    NULL,
    [ODSFName]                VARCHAR (50)    NULL,
    [ODSMName]                VARCHAR (50)    NULL,
    [ODSLName]                VARCHAR (50)    NULL,
    [NDIEligibility]          INT             CONSTRAINT [DF_PATIENT_NDIEligibility] DEFAULT ((-1)) NULL,
    [HCDPCoverageId]          INT             CONSTRAINT [DF_PATIENT_HCDPCoverageId] DEFAULT ((-1)) NULL,
    [PatientIdentifier]       VARCHAR (50)    NULL,
    [UICId]                   BIGINT          NULL,
    [PatientDeceased]         BIT             CONSTRAINT [DF_PATIENT_PatientDeceased] DEFAULT ((0)) NULL,
    [RegistrationTypeId]      BIGINT          CONSTRAINT [DF_PATIENT_RegistrationTypeId] DEFAULT ((0)) NULL,
    [NEDPatientDMISId]        BIGINT          CONSTRAINT [DF_PATIENT_NEDPatientDMISId] DEFAULT ((2011)) NULL,
    CONSTRAINT [PK_PATIENT] PRIMARY KEY CLUSTERED ([PatientId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_KEY]
    ON [dbo].[PATIENT]([PatientKey] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_FULLNAME]
    ON [dbo].[PATIENT]([FullName] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_SSN]
    ON [dbo].[PATIENT]([SSN] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_SPONSORSSN]
    ON [dbo].[PATIENT]([SponsorSSN] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_FAMILYMEMBERPREFIXID]
    ON [dbo].[PATIENT]([FamilyMemberPrefixId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_PseudoPatientId]
    ON [dbo].[PATIENT]([PseudoPatientId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_SEX_AGE]
    ON [dbo].[PATIENT]([Sex] ASC, [PatientAge] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_PatientId,CurrentPCMId]
    ON [dbo].[PATIENT]([PatientId] ASC, [FullName] ASC, [Sex] ASC, [DOB] ASC, [SSN] ASC, [CurrentPCMId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_CurrentPCMId]
    ON [dbo].[PATIENT]([CurrentPCMId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_DISPLAYAGE]
    ON [dbo].[PATIENT]([DisplayAge] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_DOB]
    ON [dbo].[PATIENT]([DOB] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_SponsorSSN_FamilyMemberPrefixId]
    ON [dbo].[PATIENT]([SponsorSSN] ASC, [FamilyMemberPrefixId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_PatientAge]
    ON [dbo].[PATIENT]([PatientAge] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_NameFields]
    ON [dbo].[PATIENT]([FullName] ASC, [NedLName] ASC, [ODSLName] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_DMISid]
    ON [dbo].[PATIENT]([DMISId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_NedLName_PatientId]
    ON [dbo].[PATIENT]([PatientId] ASC, [NedLName] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_UpdateNames]
    ON [dbo].[PATIENT]([FullName] ASC, [NedLName] ASC, [ODSLName] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_StateId]
    ON [dbo].[PATIENT]([StateId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_Sex]
    ON [dbo].[PATIENT]([Sex] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_FullName_Sex]
    ON [dbo].[PATIENT]([FullName] ASC, [Sex] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_SponsorSSN_INC_PatientId]
    ON [dbo].[PATIENT]([SponsorSSN] ASC)
    INCLUDE([PatientId], [FullName]);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_PatientIdentifier]
    ON [dbo].[PATIENT]([PatientIdentifier] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_PatientDeceased]
    ON [dbo].[PATIENT]([PatientDeceased] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'0=NO;1=YES;2=NULL', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PATIENT', @level2type = N'COLUMN', @level2name = N'ActiveDuty';

