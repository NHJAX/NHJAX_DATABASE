CREATE VIEW dbo.vwODS_PATIENT
AS
SELECT     PAT.PatientId, PAT.FullName, PAT.Phone, PAT.OfficePhone, PAT.StreetAddress1, PAT.StreetAddress2, PAT.StreetAddress3, PAT.City, 
                      dbo.GEOGRAPHIC_LOCATION.GeographicLocationAbbrev, PAT.ZipCode, PAT.SSN, RIGHT(PAT.SSN, 4) AS LastFour, PAT.Sex, PAT.DOB, PAT.DisplayAge, 
                      PAT.SponsorSSN, dbo.FAMILY_MEMBER_PREFIX.FamilyMemberPrefixCode, dbo.MILITARY_GRADE_RANK.MilitaryGradeRankDesc, PAT.PharmacyComment, 
                      PAT.CreatedDate, PAT.UpdatedDate, PAT.ActiveDuty, PAT.PatientIdentifier
FROM         dbo.PATIENT AS PAT INNER JOIN
                      dbo.vwSTG_STG_PATIENT_ACTIVITY AS PACT ON PAT.PatientKey = PACT.Patient_Ien INNER JOIN
                      dbo.GEOGRAPHIC_LOCATION ON PAT.StateId = dbo.GEOGRAPHIC_LOCATION.GeographicLocationId INNER JOIN
                      dbo.FAMILY_MEMBER_PREFIX ON PAT.FamilyMemberPrefixId = dbo.FAMILY_MEMBER_PREFIX.FamilyMemberPrefixId INNER JOIN
                      dbo.MILITARY_GRADE_RANK ON PAT.MilitaryGradeRankId = dbo.MILITARY_GRADE_RANK.MilitaryGradeRankId

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PAT"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 229
            End
            DisplayFlags = 280
            TopColumn = 47
         End
         Begin Table = "PACT"
            Begin Extent = 
               Top = 6
               Left = 267
               Bottom = 84
               Right = 418
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GEOGRAPHIC_LOCATION"
            Begin Extent = 
               Top = 84
               Left = 267
               Bottom = 192
               Right = 476
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "FAMILY_MEMBER_PREFIX"
            Begin Extent = 
               Top = 114
               Left = 38
               Bottom = 222
               Right = 251
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "MILITARY_GRADE_RANK"
            Begin Extent = 
               Top = 192
               Left = 289
               Bottom = 300
               Right = 503
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
 ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwODS_PATIENT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'        Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwODS_PATIENT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwODS_PATIENT';

