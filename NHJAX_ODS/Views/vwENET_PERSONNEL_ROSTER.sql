CREATE VIEW dbo.vwENET_PERSONNEL_ROSTER
AS
SELECT DISTINCT 
                      TECH.UserId, TECH.ULName, TECH.UFName, TECH.UMName, TECH.LoginId, TECH.BaseId, TECH.AudienceId, TECH.SSN, TECH.DOB, 
                      TECH.EMailAddress, AUD.DisplayName AS DEPARTMENTDESC, ADA.DirectorateDesc, ADA.Description, TECH.Title, TECH.HealthcareStatusId, 
                      DESIG.DesignationDesc, dbo.vwENET_BASE.BaseName, DESIG.DesignationId
FROM         dbo.vwENET_BASE RIGHT OUTER JOIN
                      [NHJAX-SQL-1A].ENET.DBO.AUDIENCE AS AUD ON dbo.vwENET_BASE.BaseId = AUD.BaseId RIGHT OUTER JOIN
                      [NHJAX-SQL-1A].ENET.DBO.TECHNICIAN AS TECH LEFT OUTER JOIN
                      [NHJAX-SQL-1A].ENET.DBO.ACTIVE_DIRECTORY_ACCOUNT AS ADA ON TECH.LoginId = ADA.LoginID LEFT OUTER JOIN
                      [NHJAX-SQL-1A].ENET.DBO.DESIGNATION AS DESIG ON TECH.DesignationId = DESIG.DesignationId ON AUD.AudienceId = TECH.AudienceId
WHERE     (TECH.Inactive = 0) AND (TECH.ServiceAccount = 0) AND (ADA.Inactive = 0) AND (ADA.ADExpiresDate >= GETDATE()) AND (TECH.UserId NOT IN (1817, 
                      4463, 6106, 6179)) AND (ADA.Description NOT LIKE '%ASTC%') AND (ADA.Description NOT LIKE '%ARMY%') AND 
                      (ADA.Description NOT LIKE '%NAR MEDICAL%') AND (ADA.Description NOT LIKE '%NECE%')

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
         Begin Table = "vwENET_BASE"
            Begin Extent = 
               Top = 114
               Left = 38
               Bottom = 222
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AUD"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 217
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TECH"
            Begin Extent = 
               Top = 6
               Left = 255
               Bottom = 114
               Right = 433
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ADA"
            Begin Extent = 
               Top = 6
               Left = 471
               Bottom = 114
               Right = 674
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DESIG"
            Begin Extent = 
               Top = 114
               Left = 227
               Bottom = 222
               Right = 386
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
      Begin ColumnWidths = 19
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
  ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwENET_PERSONNEL_ROSTER';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'       Width = 1500
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
         Filter = 2535
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwENET_PERSONNEL_ROSTER';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwENET_PERSONNEL_ROSTER';

