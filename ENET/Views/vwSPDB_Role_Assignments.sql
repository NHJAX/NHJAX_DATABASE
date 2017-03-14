CREATE VIEW dbo.vwSPDB_Role_Assignments
AS
SELECT     PERMS.ScopeUrl, USER_INFO.tp_Email, ROLE_ASSIGNMENT.RoleId, Webs.Title
FROM         [NHJAX-SPDB-2012].WSS_Content.dbo.RoleAssignment AS ROLE_ASSIGNMENT INNER JOIN
                      [NHJAX-SPDB-2012].WSS_Content.dbo.Perms AS PERMS ON ROLE_ASSIGNMENT.SiteId = PERMS.SiteId AND 
                      ROLE_ASSIGNMENT.ScopeId = PERMS.ScopeId INNER JOIN
                      [NHJAX-SPDB-2012].WSS_Content.dbo.UserInfo AS USER_INFO ON ROLE_ASSIGNMENT.PrincipalId = USER_INFO.tp_ID INNER JOIN
                      [NHJAX-SPDB-2012].WSS_Content.dbo.Webs AS Webs ON PERMS.SiteId = Webs.SiteId AND PERMS.WebId = Webs.Id

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
         Begin Table = "ROLE_ASSIGNMENT"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 115
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PERMS"
            Begin Extent = 
               Top = 6
               Left = 227
               Bottom = 115
               Right = 411
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "USER_INFO"
            Begin Extent = 
               Top = 6
               Left = 449
               Bottom = 115
               Right = 675
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Webs"
            Begin Extent = 
               Top = 6
               Left = 713
               Bottom = 115
               Right = 922
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
         Width = 3120
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2610
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwSPDB_Role_Assignments';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwSPDB_Role_Assignments';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwSPDB_Role_Assignments';

