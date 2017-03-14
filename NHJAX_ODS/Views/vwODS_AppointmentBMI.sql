CREATE VIEW dbo.vwODS_AppointmentBMI
AS
SELECT DISTINCT 
                      TOP (100) PERCENT dbo.PATIENT_ENCOUNTER.PatientId, dbo.PATIENT_ENCOUNTER.AppointmentDateTime, 
                      dbo.PATIENT_ENCOUNTER.PatientEncounterId, dbo.vwODS_VITAL_BMI.Result, dbo.vwENET_TECHNICIAN.BaseId
FROM         dbo.PATIENT_ENCOUNTER INNER JOIN
                      dbo.vwODS_VITAL_BMI ON dbo.PATIENT_ENCOUNTER.PatientEncounterId = dbo.vwODS_VITAL_BMI.PatientEncounterId INNER JOIN
                      dbo.PATIENT ON dbo.PATIENT_ENCOUNTER.PatientId = dbo.PATIENT.PatientId INNER JOIN
                      dbo.vwENET_TECHNICIAN ON dbo.PATIENT.SSN = dbo.vwENET_TECHNICIAN.SSN
WHERE     (dbo.vwENET_TECHNICIAN.DesignationId IN (3, 5))
ORDER BY dbo.PATIENT_ENCOUNTER.PatientId

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[43] 4[20] 2[15] 3) )"
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
               Top = 21
               Left = 357
               Bottom = 217
               Right = 550
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwODS_VITAL_BMI"
            Begin Extent = 
               Top = 41
               Left = 574
               Bottom = 149
               Right = 737
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "PATIENT"
            Begin Extent = 
               Top = 14
               Left = 126
               Bottom = 122
               Right = 333
            End
            DisplayFlags = 280
            TopColumn = 39
         End
         Begin Table = "vwENET_TECHNICIAN"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 234
               Right = 227
            End
            DisplayFlags = 280
            TopColumn = 16
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
         Width = 2265
         Width = 2430
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
 ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwODS_AppointmentBMI';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'        Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwODS_AppointmentBMI';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwODS_AppointmentBMI';

