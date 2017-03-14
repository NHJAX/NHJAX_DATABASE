CREATE VIEW dbo.vwODS_Patient_Activity_SelectStats
AS
SELECT     PA.PatientId, ISNULL(PA1.HospitalVisits, 0) AS Hosp1, ISNULL(PA2.HospitalVisits, 0) AS Hosp2, ISNULL(PA3.OutpatientVisits, 0) AS Out3, 
                      ISNULL(PA4.OutpatientVisits, 0) AS Out4, ISNULL(PA5.ERVisits, 0) AS ER5, ISNULL(PA6.ERVisits, 0) AS ER6, ISNULL(PA7.DispensingEvents, 0) 
                      AS Disp7
FROM         dbo.PATIENT_ACTIVITY AS PA LEFT OUTER JOIN
                      dbo.vwODS_PATIENT_ENCOUNTER_SelectERVisits AS PA5 ON PA.PatientId = PA5.PatientId LEFT OUTER JOIN
                      dbo.vwODS_PRESCRIPTION_SelectDispensingEvents AS PA7 ON PA.PatientId = PA7.PatientId LEFT OUTER JOIN
                      dbo.vwODS_PATIENT_ENCOUNTER_SelectOutpatientVisits_Asthma AS PA4 ON PA.PatientId = PA4.PatientId LEFT OUTER JOIN
                      dbo.vwODS_PATIENT_ENCOUNTER_SelectERVisits_Asthma AS PA6 ON PA.PatientId = PA6.PatientId LEFT OUTER JOIN
                      dbo.vwODS_PATIENT_ENCOUNTER_SelectOutpatientVisits AS PA3 ON PA.PatientId = PA3.PatientId LEFT OUTER JOIN
                      dbo.vwODS_PATIENT_ENCOUNTER_SelectHospitalVisits_Asthma AS PA2 ON PA.PatientId = PA2.PatientId LEFT OUTER JOIN
                      dbo.vwODS_PATIENT_ENCOUNTER_SelectHospitalVisits AS PA1 ON PA.PatientId = PA1.PatientId

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[24] 3) )"
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
         Begin Table = "PA"
            Begin Extent = 
               Top = 6
               Left = 227
               Bottom = 99
               Right = 378
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PA4"
            Begin Extent = 
               Top = 84
               Left = 416
               Bottom = 162
               Right = 572
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PA5"
            Begin Extent = 
               Top = 143
               Left = 226
               Bottom = 221
               Right = 377
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PA6"
            Begin Extent = 
               Top = 162
               Left = 421
               Bottom = 240
               Right = 572
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PA7"
            Begin Extent = 
               Top = 154
               Left = 19
               Bottom = 232
               Right = 183
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PA3"
            Begin Extent = 
               Top = 104
               Left = 38
               Bottom = 182
               Right = 194
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PA2"
            Begin Extent = 
               Top = 6
               Left = 416
               Bottom = 84
               Right = 567
            End
            DisplayFlags = 280
            TopColumn = 0
   ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwODS_Patient_Activity_SelectStats';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwODS_Patient_Activity_SelectStats';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'      End
         Begin Table = "PA1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 84
               Right = 189
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
         Alias = 900
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwODS_Patient_Activity_SelectStats';

