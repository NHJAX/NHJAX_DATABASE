CREATE VIEW dbo.vwODS_MammoEncounters
AS
SELECT DISTINCT P.PatientId AS patientid
FROM         dbo.PATIENT_ENCOUNTER AS PE INNER JOIN
                      dbo.PATIENT_PROCEDURE AS PP ON PE.PatientEncounterId = PP.PatientEncounterId INNER JOIN
                      dbo.CPT ON PP.CptId = dbo.CPT.CptId RIGHT OUTER JOIN
                      dbo.PATIENT AS P ON PE.PatientId = P.PatientId
WHERE     (PE.AppointmentDateTime > dbo.StartOfDay(DATEADD(m, - 24, GETDATE()))) AND (dbo.CPT.CptCode IN ('76090', '76091', '76092', '19180.50', 
                      '19200.50', '19220.50', '19240.5')) AND (P.Sex = 'female') AND (P.PatientAge BETWEEN 42 AND 79)
UNION
SELECT DISTINCT P.PatientId AS patientid
FROM         dbo.PATIENT_ENCOUNTER AS PE INNER JOIN
                      dbo.PATIENT_PROCEDURE AS PP ON PE.PatientEncounterId = PP.PatientEncounterId RIGHT OUTER JOIN
                      dbo.PATIENT AS P ON PE.PatientId = P.PatientId INNER JOIN
                      dbo.ENCOUNTER_DIAGNOSIS AS ED ON PE.PatientEncounterId = ED.PatientEncounterId INNER JOIN
                      dbo.DIAGNOSIS AS D ON ED.DiagnosisId = D.DiagnosisId
WHERE     (PE.AppointmentDateTime > dbo.StartOfDay(DATEADD(m, - 24, GETDATE()))) AND (D.DiagnosisCode IN ('v76.11', 'v76.12', '87.36', '87.37')) AND 
                      (P.Sex = 'female') AND (P.PatientAge BETWEEN 42 AND 79)
UNION
SELECT DISTINCT P.PatientId AS patientid
FROM         dbo.RADIOLOGY_EXAM AS RE INNER JOIN
                      dbo.PATIENT AS P ON RE.PatientId = P.PatientId INNER JOIN
                      dbo.RADIOLOGY AS R ON RE.RadiologyId = R.RadiologyId
WHERE     (R.CptId IN (7888.000, 7887.000, 7886.000)) AND (RE.ExamDateTime > dbo.StartOfDay(DATEADD(m, - 24, GETDATE()))) AND (P.Sex = 'female') AND 
                      (P.PatientAge BETWEEN 42 AND 79)

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
         Configuration = "(H (4[30] 2[40] 3) )"
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
      ActivePaneConfig = 3
   End
   Begin DiagramPane = 
      PaneHidden = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
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
      Begin ColumnWidths = 5
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwODS_MammoEncounters';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwODS_MammoEncounters';

