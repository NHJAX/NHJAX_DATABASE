﻿CREATE VIEW dbo.vwODS_PATIENT_ENCOUNTER_SelectOutpatientVisits_Asthma
AS
SELECT     dbo.PATIENT_ENCOUNTER.PatientId, COUNT(dbo.PATIENT_ENCOUNTER.PatientId) AS OutpatientVisits
FROM         dbo.PATIENT_ENCOUNTER INNER JOIN
                      dbo.ENCOUNTER_DIAGNOSIS AS ED ON dbo.PATIENT_ENCOUNTER.PatientEncounterId = ED.PatientEncounterId INNER JOIN
                      dbo.DIAGNOSIS AS DIAG ON ED.DiagnosisId = DIAG.DiagnosisId
WHERE     (dbo.PATIENT_ENCOUNTER.AppointmentDateTime BETWEEN DATEADD(m, - 12, GETDATE()) AND GETDATE()) AND 
                      (dbo.PATIENT_ENCOUNTER.AppointmentStatusId IN (2, 5)) AND (DIAG.DiagnosisCode LIKE '493%') AND (DIAG.DiagnosisCode <> '493.2')
GROUP BY dbo.PATIENT_ENCOUNTER.PatientId

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
         Begin Table = "PATIENT_ENCOUNTER"
            Begin Extent = 
               Top = 5
               Left = 5
               Bottom = 113
               Right = 214
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DIAG"
            Begin Extent = 
               Top = 20
               Left = 443
               Bottom = 128
               Right = 612
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ED"
            Begin Extent = 
               Top = 17
               Left = 236
               Bottom = 125
               Right = 436
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
      Begin ColumnWidths = 12
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwODS_PATIENT_ENCOUNTER_SelectOutpatientVisits_Asthma';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwODS_PATIENT_ENCOUNTER_SelectOutpatientVisits_Asthma';
